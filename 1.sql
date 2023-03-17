{\rtf1\ansi\ansicpg1252\cocoartf2708
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red0\green0\blue0;\red223\green223\blue223;
}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;\csgray\c0\c0;\cssrgb\c89804\c89804\c89804;
}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sa240\partightenfactor0

\f0\fs27\fsmilli13680 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec4 SELECT product_id, name, price, ROW_NUMBER() OVER w as product_number, \
                                RANK() OVER w as product_rank, \
                                DENSE_RANK() OVER w as product_dense_rank\
FROM products\
WINDOW w AS (ORDER BY price DESC)}