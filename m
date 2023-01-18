Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C7671DC7
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 14:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjARNbQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 08:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjARNa7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 08:30:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274D5D7F1;
        Wed, 18 Jan 2023 04:56:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674046580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c3JFb7ryDvxt6kfTas+EBXgdHnTgzdObc57Vw9ZeH+c=;
        b=Nodu27AXlLxNvR01o72/eGEydh9odKAZVZ5noVEBsdesLRCSYrjU9QuBSk4kb+5eWYsEyF
        3UP0c8QaOXauXXAng5bhh6wBVMrN3ZWBa7FEBkWTIyfPsj8JaElneVtJwiaWD8kCCAJdOn
        wVkIsSrWh5/8rk6bslyWNgTqlVRVTqIPaTrwIakG3YkK+KvDUVe8Z2dtsJY5gQleaN1Ezc
        GtmZieQQI7ZVo2geZNqrONG0LW3RIWrZSNTMhzR0x6Ppt5degHmZNXdbyzAZYICI2/+SeF
        qZQd2YRvsoDnAVhupx8bvXGD/T8eUaQxeoq3FYUhVsJY5SdeQtOu4KQn7sFV9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674046580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c3JFb7ryDvxt6kfTas+EBXgdHnTgzdObc57Vw9ZeH+c=;
        b=btvVIsdUqZqOBINfPovUxKB+RcZR5WH9mtBeSgIMabnAfLl6E8+358Ha6x+uXFIfxh7GhQ
        hN8V+xeDi2kAdNBw==
To:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
Subject: Re: [PATCH RFC v7 06/23] dept: Add proc knobs to show stats and
 dependency graph
In-Reply-To: <1673235231-30302-7-git-send-email-byungchul.park@lge.com>
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
 <1673235231-30302-7-git-send-email-byungchul.park@lge.com>
Date:   Wed, 18 Jan 2023 13:56:19 +0100
Message-ID: <87zgaghuh8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 09 2023 at 12:33, Byungchul Park wrote:
> It'd be useful to show Dept internal stats and dependency graph on
> runtime via proc for better information. Introduced the knobs.

proc?

That's what debugfs is for.
