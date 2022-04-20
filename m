Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23035089E4
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Apr 2022 15:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379256AbiDTOAR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Apr 2022 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358948AbiDTOAP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Apr 2022 10:00:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B4043493;
        Wed, 20 Apr 2022 06:57:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a15so1978973pfv.11;
        Wed, 20 Apr 2022 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HpMPiUGHpXCsgnMCagieewwrqdtad7tzOvjt/RtNvd0=;
        b=UdMn9sXzMeLQSq47m58dcrWjNAfrZCJsqJ1gdtKD+H3AgYyx3PQ0jut3Dw8czzvHtz
         TIC9b4dYsXDcWLYD0WwJ1K1pfdrFs1Qxgo6aQ4pufBhkQKj/bFnq4xpKmXtHx4oDWl2X
         DwHh9hNwOlL9qbsacaKOROsl1vWMqAEjoU4aIFtu39Zgz4KXv98tf/kQqhfTEZzSOeQH
         hjXwz4MNWqGeV6LJCATqk60zN3N4H+W4nN+Ul7+si0pl2P+0bN43fDCi6llDlcXCu4SM
         1A8suRbwloopErfaQ2wARpC11Vd8l7FYQEbVyt0Dsm7HooLDvCh1oG8xe0w4odm7H34v
         HPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HpMPiUGHpXCsgnMCagieewwrqdtad7tzOvjt/RtNvd0=;
        b=enUwcTS73KvvVEtG0xMo5id7zDNdIwdW7jjBoXwfC6WtMp5g4iz8s2WlPYe1Bsxh1O
         YVqsVH6dSUMWoib2RgLffr49+8Cc8V9ysM8FImxpblp7CiUEObZZp2cHcVpxnHJAPgIs
         NMgkUkwAGT+Kg2Jb1KmkwZm6M7OkObF4LFyWjKIL+xFYct9H2LcNrFg0Jcx9o/zcIdZp
         nikcfUgaD6otp6mdnAj+2/pdyX+4RpGAwXge9wrM8CWXRj8k+wsunPjY6I+NM6E+ekB3
         zkc6jNPkJvlYuZ9kMxeTMq2oEmoUW1vPgpl8vJa/lj0pP70xQxWkOKS4YoDfkqxp2B5g
         60RA==
X-Gm-Message-State: AOAM530R7WK3PEKzVxolNVGhgyxESzebHwZloXAPX2RZQVv8XYDGoh3b
        01wYrwlEfpHoiiS0VHSnr24=
X-Google-Smtp-Source: ABdhPJw/0fIpt1yg2bRHai5xIYiXrW/+gGepiyH7f+HN7RAFp1o0ohn5kiqdM4MTrbNiFV2pdBy2pw==
X-Received: by 2002:a63:6fc4:0:b0:393:9567:16dc with SMTP id k187-20020a636fc4000000b00393956716dcmr19105513pgc.593.1650463049011;
        Wed, 20 Apr 2022 06:57:29 -0700 (PDT)
Received: from [192.168.1.46] (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id h20-20020a056a001a5400b0050abaf55b5fsm3476770pfv.191.2022.04.20.06.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 06:57:28 -0700 (PDT)
Message-ID: <032b3468-4328-eda6-d3ce-6fda6673ab14@gmail.com>
Date:   Wed, 20 Apr 2022 21:57:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] kernel BUG in ext4_es_cache_extent
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu
References: <0000000000003d898d05d759c00a@google.com>
 <e58c5085-c351-a7a6-fe97-3da6eb1a804f@gmail.com>
 <20220420121626.edhvfibz4n3trnvg@quack3.lan>
From:   Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <20220420121626.edhvfibz4n3trnvg@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 4/20/2022 8:16 PM, Jan Kara wrote:
> On Mon 14-02-22 02:03:37, Phi Nguyen wrote:
>> The non-journal mounted fs is corrupted, syzbot was able to mount it because
>> a [fast commit] patch exclude its inodes from verification process.
>>
>> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> master
> 
> This patch seems to have fallen through the cracks. Phi, care to submit it
> properly with your Signed-off-by etc?
> 
> 								Honza
> 
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 01c9e4f743ba..385f4ae71573 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4912,7 +4912,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>>   		goto bad_inode;
>>   	} else if (!ext4_has_inline_data(inode)) {
>>   		/* validate the block references in the inode */
>> -		if (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
>> +		if (!(journal && EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
>>   			(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
>>   			(S_ISLNK(inode->i_mode) &&
>>   			!ext4_inode_is_fast_symlink(inode)))) {
> 

Okay, I will send a patch.

BR,
Phi
