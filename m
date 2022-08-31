Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4F35A783B
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 09:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiHaH4g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 03:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiHaH4U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 03:56:20 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4503DBD6;
        Wed, 31 Aug 2022 00:55:59 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id fy31so26307657ejc.6;
        Wed, 31 Aug 2022 00:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=K87iipJyskGUTms3Hh4Q3eouXOQ7qIXcNh/72K9zLRw=;
        b=QhW75smbf8hdKJOEi3KRrfhlwiMktrGgGcafzjet23ni2/C4GtTmj2Qba69LvSfkJX
         So86d0W3AYTsDAyF36meYVicsYSs9Gx1d3D0OucvGVI1AnyLmrIk8clJcgxxYx58gnMC
         1gLIVlLQkyxcEa5tzBR39FkF/SAif1fKQdQD2GQZrYKvcTeAAIZHpp6aydYS4VEy/pIY
         AsqQ9nSc5lTgBqsf5VyLX5ymd3SnPHb4JNR3YD7HonufRFSHsYRlqxhopFHq14Db2QGp
         dYEmH75h3MDv88tq2r5fAmO+8yYxmtZlyEeq3q+WEYC7nbqUAAYhriX39vXWdmrc3lOJ
         s1gg==
X-Gm-Message-State: ACgBeo0XQb7Ao9RfmAicDKJ4Ik/xwSKkDnswWGXu7YCurpjN8+e3YWGI
        IcQ449n+3hGheGRzXekyJpC+1oAZaKZecw==
X-Google-Smtp-Source: AA6agR4qVuwfnS2CQz4jDeWB0iNu344e5bd/jXgKf7bkufU0jn/dZoIvJ3uwto4r44/DA+gHw+8ivA==
X-Received: by 2002:a17:907:7b8d:b0:741:9c4d:a48 with SMTP id ne13-20020a1709077b8d00b007419c4d0a48mr8284295ejc.746.1661932558065;
        Wed, 31 Aug 2022 00:55:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906304d00b0073c8d4c9f38sm6935965ejd.177.2022.08.31.00.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 00:55:57 -0700 (PDT)
Message-ID: <a3544988-5503-ae0e-3c66-a75019b673c0@kernel.org>
Date:   Wed, 31 Aug 2022 09:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: ext2/zram issue [was: Linux 5.19]
Content-Language: en-US
To:     charlie39@cock.li
Cc:     adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        torvalds@linux-foundation.org, tytso@mit.edu
References: <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <20220830214626.26544-1-charlie39@cock.li>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220830214626.26544-1-charlie39@cock.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 30. 08. 22, 23:46, charlie39@cock.li wrote:
> Hi, I think i bumped on  the same issue on version 5.19.2 with ext4 on zram mounted on /tmp

Only 5.19.6 contains the fix.

> ```
> # sudo dmesg -T | grep ext4
> 
> [Tue Aug 30 21:41:45 2022] EXT4-fs error (device zram1): ext4_check_bdev_write_error:218: comm kworker/u8:3: Error while
> [Tue Aug 30 21:41:45 2022] EXT4-fs warning (device zram1): ext4_end_bio:347: I/O error 10 writing to inode 76 starting b
> [Tue Aug 30 21:41:45 2022] EXT4-fs warning (device zram1): ext4_end_bio:347: I/O error 10 writing to inode 76 starting b
> [Tue Aug 30 21:41:45 2022] EXT4-fs warning (device zram1): ext4_end_bio:347: I/O error 10 writing to inode 66 starting b
> [Tue Aug 30 22:07:02 2022] EXT4-fs error (device zram1): ext4_journal_check_start:83: comm ThreadPoolForeg: Detected abo
> [Tue Aug 30 22:07:02 2022] EXT4-fs (zram1): Remounting filesystem read-only
> 
> ```
> Not sure what caused it, i was just updating my arch system.
> 

-- 
js

