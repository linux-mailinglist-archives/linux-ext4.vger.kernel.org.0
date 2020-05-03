Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0411C2C84
	for <lists+linux-ext4@lfdr.de>; Sun,  3 May 2020 14:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgECMwa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 May 2020 08:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgECMwa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 May 2020 08:52:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4AC061A0C
        for <linux-ext4@vger.kernel.org>; Sun,  3 May 2020 05:52:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d17so17543511wrg.11
        for <linux-ext4@vger.kernel.org>; Sun, 03 May 2020 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GLeJXzh/B8dRu76vlsSovp06eFw86bismr4DVFJeKqU=;
        b=Na7j4Gn91+vw0NHVtLSXMbiOHelWndIDa/ye9VVs93/Cc3QrmG/wndCGNgSArhI5F8
         gTIqeei7XYQHtshw/fd5YnYATBg/RrVQ5NiS+f6r4hjCY3EzRZBz3Y8v47O1+gSiqE7r
         YZY0wAaq50Iutly22mybJJMtNYzx7AuwfRt+vcUYStzdShsjzXcDOQl6QdX4LeRojuhC
         Jp1pZECV1CPirTFKBjmvcv9skP/Ywo/oDZ6y+kHT122CgAM1lFeP4RrjbJ/gwKOADajF
         GfzenM543MiVuVqN4oGQI5ydAFEmsacEq3Cmh6MC1lUG5wXAXhbiciMJYw1vIDPv8AuZ
         kQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GLeJXzh/B8dRu76vlsSovp06eFw86bismr4DVFJeKqU=;
        b=IJkftKyV2mJmYwHWHUDOnHrwOz5ZWMCive9zyNFOpZqMI0KycNiRCqSBqrzvTww/xP
         0MzG8SXxcSRBmkmlWbMqPqccd9fLM7ZzhDd82ouYjD96zynMaf6PM7fJZBWrEXVbE+q0
         rg9PvGpdK9fUN77EyFQ2xRmxsJ1hv7zD/1b7AuOL3iwr+8jXaTm/I/QsVZ8uvrCSPmE3
         JEC3foFXhfPES0gDMhwsJFCo3dZXRKJrCeIZHxNZmddo3M+GH4wGLLk6i74Vs7Vf8w5Z
         6ebGZjvZP1JXgBq+LQgaPmmZ5YtNu9IJK4vRMHNqAROkg14Aj/468Trm5xvoVAJj5n3P
         JHKA==
X-Gm-Message-State: AGi0PuavJeDmCzD5iI1d0mdUzg8Q+5IngTwk5/y7dUEY8ljEnJy/1FqN
        7qYaGnMj+jGlmJJhbLXQAQw+4g==
X-Google-Smtp-Source: APiQypJWOp1hsuP2izJRehLzL3QqPYhI9RTLyZw5sDg6JMIhBHsYMpG7T1+EOgPlHynqSEseX3GbUg==
X-Received: by 2002:adf:e449:: with SMTP id t9mr2914752wrm.108.1588510346297;
        Sun, 03 May 2020 05:52:26 -0700 (PDT)
Received: from [192.168.0.12] (cpc87281-slou4-2-0-cust47.17-4.cable.virginm.net. [92.236.12.48])
        by smtp.gmail.com with ESMTPSA id i129sm9188524wmi.20.2020.05.03.05.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2020 05:52:25 -0700 (PDT)
To:     linux-ext4@vger.kernel.org
From:   Jonny Grant <jg@jguk.org>
Subject: /fs/ext4/ext4.h add a comment to ext4_dir_entry_2
Message-ID: <bf50e54f-2a0c-17a4-89c3-4afcc298daeb@jguk.org>
Date:   Sun, 3 May 2020 13:52:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello

Could a comment be added to clarify 'file_type' ?

struct ext4_dir_entry_2 {
     __le32    inode;            /* Inode number */
     __le16    rec_len;        /* Directory entry length */
     __u8    name_len;        /* Name length */
     __u8    file_type;
     char    name[EXT4_NAME_LEN];    /* File name */
};



This what I am proposing to add:

     __u8    file_type;        /* See directory file type macros below */


Thank you
Jonny
