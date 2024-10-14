import json,os
def get_prompt(context):
    '''use corresponding api to get response'''
def read_json(file):
    if os.path.exists(file):
        with open(file,'r',encoding='utf-8') as f:
            return json.load(f)
    else:
        with open(file,'w',encoding='utf-8') as f:
            f.write('[]')
            return []
    
def add_object_to_json_file(obj, filepath):
    if os.path.exists(filepath):
        with open(filepath, 'r', encoding='utf-8') as file:
            data = json.load(file)
    else:
        if isinstance(obj,dict):data={}
        else:data = []
    if isinstance(data,dict):data|=obj
    else:data.append(obj)
    with open(filepath, 'w', encoding='utf-8') as file:
        json.dump(data, file, ensure_ascii=False, indent=4)

prompt_templates={'trap':"""Following is a problem with no solution or can't be solved, and a reference answer about how to find the contradiction. There is also an answer you need to make a verdict on whether it finds the same contradiction as the reference answer does. Please output a short comment and end with [0] or [1] ([1] means the answer finds the same contradiction and explicitly states it). #The Problem: {input} \n#The Reference Answer: {ref}\n#The Answer Needs Verdict: {answer}\n#Your Verdict: """,
'original':'''Following is a math problem, a reference answer and a response you need to make a verdict on whether it is right according to the reference answer. Please output a short comment and end with [0] or [1] ([1] means right). #The Problem: {input} \n#The Reference Answer: {ref}\n#The Response Needs Verdict: {answer}\n#Your Verdict: ''',
'trueorfalse':'''Following is a true-or-false question, a reference answer and a response you need to make a verdict on whether it is right according to the reference answer. Please output a short comment and end with [0] or [1] ([1] means right). #The Question: {input} \n#The Reference Answer: {ref}\n#The Response Needs Verdict: {answer}\n#Your Verdict: '''}
scores=""
def process(inPath,outPath,READ):
    #READ==0 means evaluating answers from inPath and save verdicts to outPath. After all answers are evaluated there will be a simple statistics like 
    # inPath.json:
    # Default: wrong=10, correct=20, sum=30
    #READ==1 means loading verdicts from outPath and printing statistics again.
    prompt_template=prompt_templates['trap']
    READ0=READ
    categories={"Default":[0,0]}
    ans=[]
    data=read_json(inPath)
    outData=read_json(outPath)
    ans=outData
    haslen=len(read_json(outPath))
    count=0
    for idata in data:
        READ=READ0 or count<haslen
        count+=1
        question,output,answer=idata['input'],idata['response'],idata['answer']
        category='Default'
        dic={"input":question,"ref":answer,"answer":output}
        anses=[]
        score=0
        if READ:
            response=outData[count-1]["answer"]
        else:response=get_prompt(prompt_template.format(**dic))
        if READ:
            ai=response[0]
        else:
            ai=response
        if '[0]'in ai:score+=0
        elif '[1]'in ai:score+=1
        
        anses.append(ai)
        if not READ:print(score,ai,f'{count}/{len(data)}')
        if category in categories:
            categories[category][int(score)]+=1
        ans.append({"category":category,"question":question,"explanation":answer,"answer":output,"comment":anses[0],"score":score})
        if not READ:add_object_to_json_file(ans[-1],outPath)
        if not READ and count%50==0:
            with open(f'{outPath}_backup.json','w') as file:
                json.dump(ans,file,indent=4)
        if READ and count%100==0:print(count)
        #if count>40:break
    global scores
    scores+=f"{inPath}:\n"
    for cat in categories:
        wrong,correct=categories[cat]
        scores+=f"{cat}: wrong={wrong}, correct={correct}, sum={wrong+correct}\n"
paths=[
       ["inPath","outPath"],
       ]
READ=0
for i,j in paths:
    process(i,j,READ)
print(scores)