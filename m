Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6979E793A9A
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Sep 2023 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbjIFLDp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Sep 2023 07:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbjIFLDo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Sep 2023 07:03:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D3210F5;
        Wed,  6 Sep 2023 04:03:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a56401c12so2450835b3a.2;
        Wed, 06 Sep 2023 04:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693998220; x=1694603020; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s1qYqCtssvqiHioBvjkIJJ1Y75CiETGY1Tw2rUu5oTU=;
        b=aGTS+8Pr+DjnsxoY//GDuaFWV7CssTHAZlgzTKlrANWzsZhmyz9q9OE+WasWaUtqaA
         0ibsvUo9PopnkC7rBaYLQSkfT+tqVn/+gIFV6VcouUVJP/RkbflvipkQqC6ffPPTKmsV
         cqnC12AZNQKMQ2JwNRZbSvwcYgw+BBdV9SHzPj3+c3e+gj0h3ADFZppFnXQh7Wrv3bcz
         6wYW3JflrNCSnQ3D7ZuPUgiiFMIc8YltT847NW+t51XO1TQAVWbTnANAMRGsd3NxUZGj
         1J8HXRF/jhv4Mz3YRs5kr+StSs7SYcLUS6syUdVy6gbwoIXSeYDe4ZJ5mSQbS3jjw7Oj
         JVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693998220; x=1694603020;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1qYqCtssvqiHioBvjkIJJ1Y75CiETGY1Tw2rUu5oTU=;
        b=b0Oz705VaOOk/+rLTdqc1OpeMddaAFvIHmaYALKYZWWDd3xIHiSLUwHrUWNknjFU0D
         eeddH263ZNHlmE4+gfS5HtQ/NedpM3rezS149Z7xQnJi2kgTaxmA3PcPXIw8c4/teeX+
         yFWfEv/RQzmuUD1oQaZmIQojcaGtac/GQUfcfk4yebLB5rUfE3/QJMtwjxcqdCebNoAD
         0KAoNNafFv4YgBfLm60iGAtVttbUhmZrx7hfOmDO1inEbOCCV/2fxqmOYu01sLToDxYm
         k1epeR8PiKkWTwLwqVZn9QqN3lQz+ODa7C9F37HMh6Z6p0Sy/ofH525O9iO1+Mlhla0Z
         Ol/w==
X-Gm-Message-State: AOJu0YykpsCVixrcEV32iR06tw8TpBgQFZBgyf+C2WfbZlmOrah68DdM
        xuBq4qbAbUTEdFuPRSFyA/RPtge+V0c=
X-Google-Smtp-Source: AGHT+IFvwE/fu2/yZsMgCXl32c9r0jYFbW/R5iB3G/dzjvIHlKfu+5GOzbkxHpe1LzKa5irjB22oZg==
X-Received: by 2002:a05:6a20:914d:b0:153:4ea6:d127 with SMTP id x13-20020a056a20914d00b001534ea6d127mr2617602pzc.18.1693998220051;
        Wed, 06 Sep 2023 04:03:40 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id v19-20020a62a513000000b006732786b5f1sm10613961pfm.213.2023.09.06.04.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:03:39 -0700 (PDT)
Date:   Wed, 06 Sep 2023 16:33:35 +0530
Message-Id: <87wmx336ns.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>
Cc:     Zorro Lang <zlang@kernel.org>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org, regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery test fails
In-Reply-To: <ZPendrb8gSbAC6fM@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Sep 04, 2023 at 02:08:19AM -0400, Theodore Ts'o wrote:
>> #regzbot introduced: 8147c4c4546f9f05ef03bb839b741473b28bb560 ^
>> 
>> OK, I've isolated the regression of generic/455 failing with ext4/1k
>> to this commit, which came in via the mm tree.  Nothing seems
>> *obviously* wrong, but I'm not sure if there are any differences in
>> the semantics of the new folio functions such as kmap_local_folio,
>> offset_in_folio, set_folio_bh() which might be making a difference.
>
> Thanks for the cc,  Let's see what we can do ...
>
> virt_to_folio() - For an order-0 page, there is no difference.
> offset_in_folio() - Ditto
> bh->b_page vs bh->b_folio - Ditto
> virt_to_folio() - Ditto
> folio_set_bh() - Ditto
>
> kmap_local_folio() vs kmap_atomic - Here, we have a difference.
> memcpy_from_folio() - Same difference as above.
>
> I suppose it must be this, and yet I cannot understand how it would
> make a difference.  Perhaps you can help me?
>
> static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
> {
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                 migrate_disable();
>         else
>                 preempt_disable();
>
>         pagefault_disable();
>         return __kmap_local_page_prot(page, prot);
> }
>
> vs
>
> static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> {
>         struct page *page = folio_page(folio, offset / PAGE_SIZE);
>         return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
> }
>
> I don't believe that returning the address with the offset included
> is the problem here.  It must be disabling preemption / migration.
> There's no chace this funcation accesses userspace (... is there?) so
> it can't be the pagefault_disable().
>
> We can try splitting this up into tiny commits and figuring out which
> of them is the problem.  I'll be back at work tomorrow and can look
> more deeply then.
>
>> Using kvm-xfstests[1] I bisected this via the command:
>> 
>> % install-kconfig ; kbuild ; kvm-xfstests -c ext4/1k -C 10 generic/455
>> 
>> [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
>> 
>> 
>> And the bisection pointed me at this commit:
>> 
>>     commit 8147c4c4546f9f05ef03bb839b741473b28bb560 (refs/bisect/bad)
>>     Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>>     AuthorDate: Thu Jul 13 04:55:11 2023 +0100
>>     Commit: Andrew Morton <akpm@linux-foundation.org>
>>     CommitDate: Fri Aug 18 10:12:30 2023 -0700
>> 
>>         jbd2: use a folio in jbd2_journal_write_metadata_buffer()
>>     

This is inline with my observation too. 

However, is this log expected with below diff when running with ext4/1k?
I am finding a folio with order > 0 here.

<diff>
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 768fa05bcbed..152c08e83fa2 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -369,6 +369,12 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
                new_offset = offset_in_folio(new_folio, jh2bh(jh_in)->b_data);
        }

+       if (folio_size(new_folio) > PAGE_SIZE) {
+               pr_crit("%s: folio_size=%lu, folio_order=%d, new_offset=%u bh_size=%lu folio_test_large=%d\n",
+                       __func__, folio_size(new_folio), folio_order(new_folio), new_offset,
+                       bh_in->b_size, folio_test_large(new_folio));
+       }
+
        mapped_data = kmap_local_folio(new_folio, new_offset);
        /*
         * Fire data frozen trigger if data already wasn't frozen.  Do this

<dmesg log>
[   40.419772] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=0 bh_size=1024 folio_test_large=1
[   40.444737] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=2048 bh_size=1024 folio_test_large=1
[   40.472385] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=3072 bh_size=1024 folio_test_large=1
[   40.560581] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=8192 bh_size=1024 folio_test_large=1
[   40.588512] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=10240 bh_size=1024 folio_test_large=1
[   40.612103] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=7168 bh_size=1024 folio_test_large=1
[   40.636800] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=9216 bh_size=1024 folio_test_large=1
[   40.661166] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=10240 bh_size=1024 folio_test_large=1


Is this code path a possibility, which can cause above logs?

   ptr = jbd2_alloc() -> kmem_cache_alloc()
   <..>
   new_folio = virt_to_folio(ptr)
   new_offset = offset_in_folio(new_folio, ptr)

And then I am still not sure what the problem really is? 
Is it because at the time of checkpointing, the path is still not fully
converted to folio?

I am still missing a lot of pieces here, sorry. 

-ritesh

>> During the bisection, I treated a commit with 3+ failures as "bad",
>> and 0-2 commits as "good".  Running generic/455 50 times to get a
>> sense of the failure, with the first bad commit (8147c4c4546f), I got:
>> 
>>     ext4/1k: 50 tests, 21 failures, 223 seconds
>>       Flaky: generic/455: 42% (21/50)
>>     Totals: 50 tests, 0 skipped, 21 failures, 0 errors, 223s
>> 
>> While with the immediately preceding commit (07811230c3cd), I got:
>> 
>>     ext4/1k: 50 tests, 4 failures, 235 seconds
>>       Flaky: generic/455:  8% (4/50)
>>     Totals: 50 tests, 0 skipped, 4 failures, 0 errors, 235s
>> 
>> 
>> 
>> Comparing these two commits (8147c4c4546f vs 07811230c3cd) using the
>> ext4 with a 4k block size, I get:
>> 
>>     ext4/4k: 50 tests, 2 failures, 365 seconds
>>       Flaky: generic/455:  4% (2/50)
>>     Totals: 50 tests, 0 skipped, 2 failures, 0 errors, 365s
>> 
>> vs
>> 
>>     ext4/4k: 50 tests, 2 failures, 349 seconds
>>       Flaky: generic/455:  4% (2/50)
>>     Totals: 50 tests, 0 skipped, 2 failures, 0 errors, 349s
>> 
>> So issue seems to be specifically with a sub-page size block size,
>> since ext4/4k doesn't show any issues, while ext4/1k does.
>
> I doubt I tried it with a 1kB block size, so I'll focus on that too.
