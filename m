Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E9B72B132
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Jun 2023 11:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjFKJiN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Jun 2023 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKJiM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Jun 2023 05:38:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ABC9B
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 02:38:10 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f78a32266bso33176725e9.3
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686476289; x=1689068289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56dCB3Y+eJ0AjtxQrh87OBAVGC5sQRY197GW5uQ0Nf8=;
        b=qj96TGE+Hyzi/mKCJ9PucljToLtBl5irWqfvg4XBw2pIBbmzyEYxcui1wGdzMu6clF
         ahjAOmBYH1OJvbi511UPlmcuExPKEdGvb6V5Aj3Kl64TH2aNCloCHeY3L1eRwq+MAKBU
         1TOC0Nd0ULf7bN3/ZmO309Wy8hAUnZMw2at/+wJHlGwikKlJgX+5m1dd5H15xTx7Dq7G
         2pJnjvaVQJydspGouWnz+z24kRFFFFgWg6vY6Zmf5GkDVOW5VhTZ0OAwwDx9O/tPnbEi
         Zs5j3Ylc0NBIbJ4Kds5D7gigt+suw2pM83KemVWiBu1gjrtXMxEATthowNRHmkNXjZox
         RrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686476289; x=1689068289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56dCB3Y+eJ0AjtxQrh87OBAVGC5sQRY197GW5uQ0Nf8=;
        b=CeLLRRGdfrPcapkBYBRj1OYV7Dyywb5M4XiF1YOAuANamb0iVLb68lCmGtlk9yD/6p
         cyGw74Ou6JMosWn+WYLByoUMjP378JKXi4EM9VfADAO6Xf1pa0z9qXBF5JMDebDD+vH7
         upC0e6qrvyOV5GYw1KLESUujiGjVDp72AfQ+mNd05IPsrjlYblcBf50AlHoBsktWr2bo
         0339Wh6J1HJAn6JXaQvXoSNNOnsft9YjPmNDB6KP9TrPOTgdfwlk5e8m8OA50XTeEewq
         /UDSVF0IS9K5uu2peLqO96kS6YacuQNAYLMmbdr9fwbdYP2Xvj69axACqA/Tlw3IKvch
         eoUw==
X-Gm-Message-State: AC+VfDyEZUTxCqnSEo9AEB/FRBgMOO6p598xxJg3v4JAk47r3J6Noies
        DAt9PaRvFlift6yYpgbp8G4=
X-Google-Smtp-Source: ACHHUZ6mzFdKkuSUIG9MmRp9NYL4rIRkxK56uLQ4Ad3JFWZdb1MqGpU509VBNY2ZWzU209tNplQVrA==
X-Received: by 2002:a7b:c84c:0:b0:3f7:16ed:4ca3 with SMTP id c12-20020a7bc84c000000b003f716ed4ca3mr5359859wml.1.1686476289051;
        Sun, 11 Jun 2023 02:38:09 -0700 (PDT)
Received: from suse.localnet (host-95-252-166-216.retail.telecomitalia.it. [95.252.166.216])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b003f7361ca753sm7868733wmf.24.2023.06.11.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 02:38:08 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid context in
 ext4_update_super
Date:   Sun, 11 Jun 2023 11:38:07 +0200
Message-ID: <2511036.4XsnlVU6TS@suse>
In-Reply-To: <20230611032032.GC1436857@mit.edu>
References: <00000000000070575805fdc6cdb2@google.com> <7535327.EvYhyI6sBW@suse>
 <20230611032032.GC1436857@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On domenica 11 giugno 2023 05:20:32 CEST Theodore Ts'o wrote:
> (Dropping linux-fsdevel and linux-kernel from the cc list.)
> 
> On Sat, Jun 10, 2023 at 10:41:18PM +0200, Fabio M. De Francesco wrote:
> > Well, I'm a new to filesystems. However, I'd like to test a change in
> > ext4_handle_error().
> > 
> > Currently I see that errors are handled according to the next snippet of
> > code
> > 
> > from the above-mentioned function (please note that we are in atomic 
context):
> > 	if (continue_fs && journal)
> > 	
> > 		schedule_work(&EXT4_SB(sb)->s_error_work);
> > 	
> > 	else
> > 	
> > 		ext4_commit_super(sb);
> > 
> > If evaluates false, we directly call ext4_commit_super(), forgetting that,
> > AFAICS we are in atomic context.
> > 
> > As I said I have only little experience with filesystems, so my question 
is:
> > despite the overhead, can we delete the check and do the following?
> > 
> > [ Unconditionally call schedule_work(&EXT4_SB(sb)->s_error_work) ]
> 
> That doesn't work, for the simple reason that it's possible that file
> system might be configured to immediately panic on an error.  (See
> later in the ext4_handle_error() function after the check for
> test_opt(sb, ERRORS_PANIC).  If that happens, the workqueue will never
> have a chance to run.  In that case, we have to call
> ext4_commit_super().
> 
> The real answer here is that ext4_error() must never be called from an
> atomic context, and a recent commit 5354b2af3406 ("ext4: allow
> ext4_get_group_info() to fail") added a call to ext4_error() which is
> problematic since some callers of the ext4_get_group_info() function
> may be holding a spinlock.  And so the best solution is to just simply
> to drop the call to ext4_error(), since it's not strictly necessary.

Ted,

I just responded with another message, so I'm waiting to know from you whether 
or not you are okay with me submitting a patch with your "Suggested by:" tag.

In the meantime, I have had time to think of a different solution that allows 
the workqueue the chance to run even if the file system is configured to 
immediately panic on error (sorry, no code - I'm in a hurry)...

This can let you leave that call to ext4_error() that commit 5354b2af3406 
("ext4: allow ext4_get_group_info()") had introduced (if it works - please 
keep on reading).

1) Init a global variable ("glob") and set it to 0.
2) Modify the code of the error handling workqueue to set "glob" to 1, soon 
before the task is done.
3) Change the fragment that panics the system to call mdelay() in a loop  (it 
doesn't sleep - correct?) for an adequate amount of time and periodically 
check READ_ONCE(global) == 1. If true, break and then panic, otherwise 
reiterate the loop.

Could it be useful?

> If there is an antagonist process which is actively corrupting the
> superblock, some other code path will report the fact that the file
> system is corrupted soon enough.
> 
> 						- Ted
> 
> P.S.  There is an exception to what I've described above, and that's
> special ext4_grp_locked_error() which is used in fs/ext4/mballoc.c.
> But that's a special case which requires very careful handling, In
> general, you simply must not be in atomic context when you want to
> report a problem.

Haven't yet had time to look at this. So last answer is the only one I have at 
the moment.

Thanks for your time,

Fabio


