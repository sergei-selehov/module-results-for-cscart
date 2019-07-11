<?php

$schema['central']['orders']['items']['result'] = array(
    'attrs' => array(
        'class'=>'is-addon'
    ),
    'href' => 'result.manage',
    'position' => 400,
    'subitems' => array(
        'ratings' => array(
            'href' => 'result.rating',
            'position' => 203
        ),
    )
);
return $schema;

