Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF0B36F25F
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Apr 2021 00:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhD2WGk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 18:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhD2WGk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Apr 2021 18:06:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8EBC06138B;
        Thu, 29 Apr 2021 15:05:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j4so67687598lfp.0;
        Thu, 29 Apr 2021 15:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pS24tBuMJUeoaya9TnlvnHjqLdb8zYNWsRuU9yZXzgo=;
        b=Nk/k9NwO+hA2GJZ/Npp03Gb9D3esbFvOM1FnpRW6KuE30m35eXbMttEXBWP9uUmsUH
         eYd4zerzmurslm2YaX/IBKBxPXzmtFQ8SUIfz3tgNxIvmTsiNN/F7Y9N73E6fyzxN/lV
         K5qg/ThkGvfTe0GjdJSlZvP1mcsdKwaJdLvOM2qOuH3gElgsV/XcjSDuxcYoKmzCO9l7
         /favnIzuib8UrMDqgCr1UG1WM9IQOJCMhVpx8O6F0p9c/WLkzx8GVIC8beNTO2bMQ4gM
         HtIPUo3UryQm8ivOTH7TmK6sbsdGaXWsTKs15xfSb89itemBIKNO5ol9TzQeLgb4zUs6
         JqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pS24tBuMJUeoaya9TnlvnHjqLdb8zYNWsRuU9yZXzgo=;
        b=qIR8tqBbvkuiPZaWkF6domVWSU9xxO1W2eSJ0roTOvdrma9Enx0mEfujMdA9tW1lIi
         CAjf1ybIVSpoIU8Eg7JdhJPfjdY5N1SgxsO+adE2PELmNtlQ7g0myQioiyGKNyiqtvG3
         69DXpR4rdP0Kc3pEBEcvlNmnqoeU39Y93K9+07fMloRM4kvXzqeohNir4GGnJdwaawVJ
         91d22jXqjk+TB03vCzRNODAuw4V/xVVY5dcnmFoKuWwkNVrJPw+/vnjnrOg+i0OpNmcC
         pm4ce+aqUvuwuW/hp6ICQ7Sr/o6k6F51/DA1+SsYSQnygBmU7j4XS2TQKMzztXQwXaZD
         sFZQ==
X-Gm-Message-State: AOAM5313VpADt0x4aztnGWvQ8AWyp7I3d+YHUEioOGK+3fhK6dzXrGI7
        BqoCxM68b+ZbgUJuOIej4h4=
X-Google-Smtp-Source: ABdhPJwClB8QKIt8phODb/iWDW7zUJg9cMohAEAUWhd/0S3GeJYJIFjnaIug0gZ9qH3rklaJbqkdFw==
X-Received: by 2002:a19:f00a:: with SMTP id p10mr1204694lfc.510.1619733950339;
        Thu, 29 Apr 2021 15:05:50 -0700 (PDT)
Received: from localhost.localdomain ([94.103.226.84])
        by smtp.gmail.com with ESMTPSA id p23sm102836lfc.210.2021.04.29.15.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 15:05:50 -0700 (PDT)
Date:   Fri, 30 Apr 2021 01:05:47 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        akpm@linux-foundation.org, peterz@infradead.org, axboe@kernel.dk,
        pmladek@suse.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix memory leak in ext4_fill_super
Message-ID: <20210430010547.38f27e39@gmail.com>
In-Reply-To: <YIsn+JToAkPqDPq5@mit.edu>
References: <20210428172828.12589-1-paskripkin@gmail.com>
        <3c3877a4-fef2-9e24-f99f-2ecc46deb7e4@oracle.com>
        <20210429143354.418248a7@gmail.com>
        <YIrnPXJo/n68NrQs@mit.edu>
        <20210429230956.6ad23897@gmail.com>
        <YIsn+JToAkPqDPq5@mit.edu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 29 Apr 2021 17:41:12 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Thu, Apr 29, 2021 at 11:09:56PM +0300, Pavel Skripkin wrote:
> > > we will exit with -ENOMEM.  So at the very least all callers of
> > > kthread_stop() also need to check for -ENOMEM as well as -EINTR
> > > --- or, be somehow sure that the thread function was successfully
> > > called and started.  In this particular case, the ext4 mount code
> > > had just started the kmmpd thread, and then detected that
> > > something else had gone wrong, and failed the mount before the
> > > kmmpd thread ever had a chance to run.
> > 
> > There is a small problem about -ENOMEM...
> 
> What I'd suggest is that we simply move
> 
> > exit_thread:
> > 	EXT4_SB(sb)->s_mmp_tsk = NULL;
> > 	kfree(data);
> > 	brelse(bh);
> > 	return retval;
> > }
> 
> out of the thread function.  That means hanging struct mmpd_data off
> the struct ext4_sb_info structure, and then adding a function like
> this to fs/ext4/mmp.c
> 
> static void ext4_stop_mmpd(struct ext4_sb_info *sbi)
> {
> 	if (sbi->s_mmp_tsk) {
> 		kthread_stop(sbi->s_mmp_tsk);
> 		brelse(sbi->s_mmp_data->bh);
> 		kfree(sbi->s_mmp_data);
> 		sbi->s_mmp_data = NULL;
> 		sbi->s_mmp_tsk = NULL;
> 	}
> }
> 
> Basically, just move all of the cleanup so it is done after the
> kthread is stopped, so we don't have to do any fancy error checking.
> We just do it unconditionally.

This sound much better than my idea. Will do it in v2.

Thanks!

> 
> 					- Ted
> 
> P.S.  Actually, we could drop the struct mmpd_data altogether, and
> just hang the buffer head as sbi->s_mmp_bh.  Then we can just pass the
> struct super * as the private pointer to kmmpd().
> 



With regards,
Pavel Skripkin
