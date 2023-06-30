Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFEF744024
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jun 2023 18:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjF3QxL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Jun 2023 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjF3QxJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Jun 2023 12:53:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D483AB2;
        Fri, 30 Jun 2023 09:53:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so3344332e87.2;
        Fri, 30 Jun 2023 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688143986; x=1690735986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnKDhU99zIz+yl6/YbRHuy4g7+5+My9tn6hsFqI9FMA=;
        b=m50o5QSBGmbRThTFk0fh+Jn0tLn3FWPihCCxcaOpgJ3y90Q3xuY7GPtEngMJdW93AS
         oAkX7hyqeDJbV+z/WdWUSnJ/w0yT9d7LkM0KvH+fafKkMB7YkD/1GD7j+Pd4/Z6klEpe
         F+nIGMzxS5+eOOrJITg3mruEl38J8vSjw6WGcEgyZRa28FHZ6fYQ0+IQvpR8YZfmelok
         H51BfmaPvvUqj5mChteoYAu06nEchSon70t1VWw2IpWxYyXaTQmI32jCi7UhbuV0QRif
         KRpDoh2xd+i7TTSDMrJ2xb2keSoyJdyJYZO7MB5pDc4JSHPxPuUD5Awu6S4LkWrN07Fv
         2mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688143986; x=1690735986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnKDhU99zIz+yl6/YbRHuy4g7+5+My9tn6hsFqI9FMA=;
        b=eUDm+x3QbR8onf5iux3bNg/d9e/b2svfbHEfNB1EVTjRsovljcEeRzr06FlK9LEsh7
         WfGCbKynSvFWpu3jWwHypyJR003B7hz4IZlEIvPbc8qutDoLWwZ8vnuR4ucWw2d5gLNN
         3NxEsbJa4+LOZX/gZ2qaxIMiB9cz4Pfz063Gs6KC/4jU/yRJ/zYgZcIoPqkXU6KVK4j8
         JG9LHjHzdC6HjTZ5FoccKPLlgGoB+IgXr9lNdQtpIvVjP6OOD2q1ysk8Fy7Gk16OYW9A
         3re6L4RhoUFx562YiUbQVDdCpOr3azobiyOdxyVE66KQXN4g+MKVYKzydQMxtuYnj1HA
         XyvQ==
X-Gm-Message-State: ABy/qLYMDFCvkydRyGV9buL/AnM/3GhSE8tzQp/4RXsz60vq6KjqTqTQ
        /BeP2OCaWEXckEUWrYJJzcs=
X-Google-Smtp-Source: APBJJlGr8bFeQJpTqdpniL3Hf3AquG7nj9QcjiPwq3F7ictd7nwYQaF/qVFq54W8Gkx6HxkWgUIf3w==
X-Received: by 2002:a05:6512:2107:b0:4f6:6b:a43b with SMTP id q7-20020a056512210700b004f6006ba43bmr2416617lfr.52.1688143986238;
        Fri, 30 Jun 2023 09:53:06 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id 5-20020a05600c024500b003fbb00599e4sm7698158wmj.2.2023.06.30.09.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 09:53:05 -0700 (PDT)
Message-ID: <428ac287-6a4b-fb3c-dfa2-7043c3459ec7@gmail.com>
Date:   Fri, 30 Jun 2023 17:53:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH][next] ext2: remove redundant assignment to variable desc
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230630163033.165326-1-colin.i.king@gmail.com>
 <b12f7d11-4bfe-4e53-9a32-ce8db056d561@kadam.mountain>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <b12f7d11-4bfe-4e53-9a32-ce8db056d561@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 30/06/2023 17:47, Dan Carpenter wrote:
> On Fri, Jun 30, 2023 at 05:30:33PM +0100, Colin Ian King wrote:
>> Variable desc is being assigned a value that is never read, the exit
>> via label found immeditely returns with no access to desc. The
>> assignment is redundant and can be removed. Cleans up clang scan
>> muild warning:
>>
>> fs/ext2/ialloc.c:297:4: warning: Value stored to 'desc' is never
>> read [deadcode.DeadStores]
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   fs/ext2/ialloc.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
>> index a4e1d7a9c544..f50beb77d6ba 100644
>> --- a/fs/ext2/ialloc.c
>> +++ b/fs/ext2/ialloc.c
>> @@ -294,7 +294,6 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent)
>>   			best_desc = desc;
>>   		}
>>   		if (best_group >= 0) {
>> -			desc = best_desc;
> 
> You should get rid of the "best_desc" variable as well.

Good point! Will send V2. Thanks Dan.

> 
> regards,
> dan carpenter
> 

