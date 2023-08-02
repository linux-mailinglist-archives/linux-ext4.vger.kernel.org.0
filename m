Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA476D3AA
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjHBQaP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjHBQaN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 12:30:13 -0400
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 09:30:07 PDT
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A31210D
        for <linux-ext4@vger.kernel.org>; Wed,  2 Aug 2023 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690993800;
        bh=WzOjdU1RA1VtzD8KEuZ4qGc1a8nuyxKg2Tq2LgQLeCI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=wy6KRDwGIMEleXAp5ZWSNZORE9koqkasufv50LaMULyYVsPyT3R0AZ+dy6rC1aE8N
         whIqJJ70u6p2/gQETQwL37g6/8ZTSHzob6s6vyL6NHh++R/LHVAJHxMmQh/Hj4MDME
         zvXWZ3KB3WNT911Hq4/GlutNhTmfgaTWmpM5m7hM=
Received: from [IPV6:2409:8a00:2577:9740:9ca5:5f74:38db:4c67] ([2409:8a00:2577:9740:9ca5:5f74:38db:4c67])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 77A9BC8C; Thu, 03 Aug 2023 00:29:58 +0800
X-QQ-mid: xmsmtpt1690993798t9c1m2sqn
Message-ID: <tencent_798118A8D3600FCC5E0E08EEB2341A8EE206@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9/9vdW8nlMOLtAjutKo/PA6BuwwIMYAkD4PZDOt/pWrh5YICi3b
         I++WSJ2U+EYT4UVj78HiLVF84EOprpr63cGQns31N1miU5Ra3Crvwvvr40gaF9sAzkfwi549Cr4c
         JmBUSILzILQ/+CfgLTThfCEnibTrdy2zNYYTTuJj1ki77fek4a4l2+M+3G0cTl37P8qCP/uicMi7
         E25G6kTM9yzGn071hTAtTQ0VojK6BC2E8WT8s6cyHq/dSOuuRvOLzmnRmsRnEkuTl37H5guLU3Xv
         G8xZ7EPe9EiCYNycUlCiIRI3PncDhSy7YkCL1K42Pc0UUtpUvDSpFkVEApAQn3SSRhdNq9M7oC/f
         vGRcsCCZs5k7LL137cNirvZ/SHfQVOaY1C6UEdJGgd8QYxK9c5ogOlBTwEvReLcntZc7hdbK/Zka
         A44j3q4dAmASlxLCwuo6h67jJWp4UP5NEVrYtPMEA7B82UibP5Zk78s8XGo3hnjmWtbm/zO8497C
         l1vDkM1w+y1FXhDorCtdq1WLCkJiUWNHAyXuJBqqtTG+1fUjsaZnEiRRSyZ/7/WJvNWeF69oYh+e
         bFUWbcC1mSEX6cIHgTPo0yAFcpc2WtUwrOv+vABhQEpbIqmshtOeR5NqNmf18G3K3vj3RQEvYpd4
         J9t62Lf3+0KTAiwwL0TjqYIuZqn0QcdUDsgTR1xaE2wG/Sx+Ilg7DjWjCGjKf3ehEQ24PeOHnEx+
         D0dEDv24LKXbg46Y7y8USkT08UiEp3YpHG8d0IRLqrs4t+ybI4XwOTh8X7OsX4xk2JHU/K2F54HA
         Ep9rI+TLVwYHYUoZQDp4SoVcvnRxWL1/JrWspDFy+Q6SSy9R10JnqNPN/bx5tuQNuFoilVi3GQ/2
         yAYyRfgnfsT0htJR+Goy4Xz4iimGlP1DVEHx2+W54jduwJtrOe8L/NJLxCe8PkALrwoNLluqXLSm
         MLSZ8iO9TNV4DIXfjzNo/rV9b9Z3cyuh24cnwteaq4lPEU+EJcIQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <fd44a224-3c86-a8ac-2696-830f9b473d3d@foxmail.com>
Date:   Thu, 3 Aug 2023 00:29:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] ext4: Add correct group descriptors and reserved GDT
 blocks to system zone
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <tencent_4A474CC049B9E77D0F172468991EED5B9105@qq.com>
 <20230604034559.GG1128744@mit.edu>
From:   Wang Jianjian <wangjianjian0@foxmail.com>
In-Reply-To: <20230604034559.GG1128744@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Ted, I send a new fix. Please help review.

On 6/4/23 11:45, Theodore Ts'o wrote:
>> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
>> index 5504f72bbbbe..5df357763975 100644
>> --- a/fs/ext4/block_validity.c
>> +++ b/fs/ext4/block_validity.c
>> @@ -224,11 +223,14 @@ int ext4_setup_system_zone(struct super_block *sb)
>>   
>>   	for (i=0; i < ngroups; i++) {
>>   		cond_resched();
>> -		if (ext4_bg_has_super(sb, i) &&
>> -		    ((i < 5) || ((i % flex_size) == 0))) {
>> +		unsigned int sb_num = ext4_bg_has_super(sb, i);
>> +		unsigned long gdb_num = ext4_bg_num_gdb(sb, i);
>> +		unsigned int rsvd_gdt = le16_to_cpu(sbi->es->s_reserved_gdt_blocks);
>> +
>> +		if (sb_num != 0 || gdb_num != 0) {
>>   			ret = add_system_zone(system_blks,
>>   					ext4_group_first_block_no(sb, i),
>> -					ext4_bg_num_gdb(sb, i) + 1, 0);
>> +					sb_num + gdb_num + rsvd_gdt, 0);
>>   			if (ret)
>>   				goto err;
>>   		}
> 
> 
> How the reserved GDT blocks should be added to the system zone are not
> handled correctly in this patch.   It can't be unconditionally added to
> all block groups.
> 
> See the logic in ext4_num_base_meta_clusters() in fs/ext4/balloc.c ---
> without the EXT4_NUM_B2C() at the end of the function, since the
> system zone tracking is done at the block level, not the cluster
> level.
> 
> 					- Ted
> 

