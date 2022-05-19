Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47DF52E065
	for <lists+linux-ext4@lfdr.de>; Fri, 20 May 2022 01:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbiESXOW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 19:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245759AbiESXOU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 19:14:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B53106548
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 16:14:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l14so6551065pjk.2
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 16:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=Ifu9XbMxFXkI0pV69WeNPHZVkOc6gUGaHcwFj9MqZkY=;
        b=ZBdqOZJCVsq8ujnPkKNkJojkvJeTyPge3erKoumdZpkmNZvwNiC3l6WAY1k01RyHli
         yoJCSLmy4tlU144AVHtsSyFtudt/P1ah7qoUsUj5TnPhgLpVI9qQaa5EENN+VEZUjwiJ
         1maxjEcRKCTCVhSCv/IRvnegC0O07Au+gfX+TE9zpJNIqxPBR7oZfUj4dqwI+jT3jpQ4
         zYhPb+HkSEU2LnvT5yKuWQqVD9bS54oktPAfU3j4GkxmnV/g7fWMaE8kjzDAOLp3Nk6d
         AFYO2IiEcBr5CoZMuiznlryqFDZ3nAneW2yguzIcHcIj3k/0XuzidBzos9sE3o0kcqT1
         hJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=Ifu9XbMxFXkI0pV69WeNPHZVkOc6gUGaHcwFj9MqZkY=;
        b=W+g5KMXPIOKf287oD8Ki6YQuShu7JMmEjFfYWTfldKcZ1neOTB1+DioK4EN1gLQm6m
         A16+f6m2+Ic8TUz7X5lYepFNOE01M6PtufDRBEf0d67u6skdSAEtfOw42V0IC4TR5squ
         IgAxiXmaspwyrf3v/+i24Df4CLnI1x+fc3i48NIAmUMbHbYA4VI3n0vm+aWL6OUX61R0
         3OhcyCkhU8En+TGoP4TByz519sbmjBc+9RtlkIbF4U7tC6vgEW31FqNmHiGLbdrYk+Gn
         YiQgzMhf79LMBpsHfcf2Mnv11Eus4opftWepruPNmd0YHXn+GxSt3SJH4+99dz0J+a3X
         dnhA==
X-Gm-Message-State: AOAM530/0STXB92fTtBekrewk0vU4A1xg3X/KTEK7R+lJUN/9rT6ImRq
        iiqmPCLE6k1Xy+1suXtstjjwNcZldF4GVw==
X-Google-Smtp-Source: ABdhPJw/y4RUBTg3R4ufIdLCWSunz/FwodF0VJgzRYBeqzfr8/BTCNvuEkV8iXRJygz96+kN2ZpgsA==
X-Received: by 2002:a17:90a:8b91:b0:1be:db25:eecd with SMTP id z17-20020a17090a8b9100b001bedb25eecdmr7664876pjn.10.1653002058564;
        Thu, 19 May 2022 16:14:18 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id cp25-20020a056a00349900b0050dc76281c0sm199087pfb.154.2022.05.19.16.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:14:18 -0700 (PDT)
Message-ID: <e9ccb919-1616-f94f-c465-7024011ad8e5@linaro.org>
Date:   Thu, 19 May 2022 16:14:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <49ac1697-5235-ca2e-2738-f0399c26d718@linaro.org>
 <20220519122353.eqpnxiaybvobfszb@quack3.lan>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: kernel BUG in ext4_writepages
In-Reply-To: <20220519122353.eqpnxiaybvobfszb@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 5/19/22 05:23, Jan Kara wrote:
> Hi!
> 
> On Tue 10-05-22 15:28:38, Tadeusz Struk wrote:
>> Syzbot found another BUG in ext4_writepages [1].
>> This time it complains about inode with inline data.
>> C reproducer can be found here [2]
>> I was able to trigger it on 5.18.0-rc6
>>
>> [1] https://syzkaller.appspot.com/bug?id=a1e89d09bbbcbd5c4cb45db230ee28c822953984
>> [2] https://syzkaller.appspot.com/text?tag=ReproC&x=129da6caf00000
> 
> Thanks for report. This should be fixed by:
> 
> https://lore.kernel.org/all/20220516012752.17241-1-yebin10@huawei.com/


In case of the syzbot bug there is something messed up with PAGE DIRTY flags
and the way syzbot sets up the write. This is what triggers the crash:

$ ftrace -f ./repro
...
[pid  2395] open("./bus", O_RDWR|O_CREAT|O_SYNC|O_NOATIME, 000 <unfinished ...>
[pid  2395] <... open resumed> )        = 6
...
[pid  2395] write(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 22 <unfinished ...>
...
[pid  2395] <... write resumed> )       = 22

One way I could fix it was to clear the PAGECACHE_TAG_DIRTY on the mapping in
ext4_try_to_write_inline_data() after the page has been updated:

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 9c076262770d..e4bbb53fa26f 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -715,6 +715,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
  			put_page(page);
  			goto out_up_read;
  		}
+		__xa_clear_mark(&mapping->i_pages, 0, PAGECACHE_TAG_DIRTY);
  	}
  
  	ret = 1;

Please let me know it if makes sense any I will send a proper patch.

-- 
Thanks,
Tadeusz
