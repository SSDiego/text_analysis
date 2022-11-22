# -*- coding: utf-8 -*-
"""
Created on Sat Nov 19 09:35:16 2022

@author: sp2di
"""

from tika import parser
import glob
import os
#from tabula import read_pdf # para extração de tabela

#Definir diretório
os.chdir(r"D:\projectLN\dea")
 

#Criar lista de pdfs no diretório
pdfs = []
for file in glob.glob("*.pdf"):
    print(file)
    pdfs.append(file)
    
    
#Extrair pdf text e salvar conteúdo numa lista    
pdfs_texts = []

for i in range(len(pdfs)):
    string = pdfs[i] 
    arquivo = []    
    parsed_pdf = parser.from_file(string)
    data = parsed_pdf['content'] 
    pdfs_texts.append(data)
    
    #Escrever txt
    with open(pdfs[i]+".txt", "w", encoding = 'utf-8') as output: 
        output.write(data)
         
       
# para extração de tabelas # df = read_pdf("NT.pdf",pages="all")   