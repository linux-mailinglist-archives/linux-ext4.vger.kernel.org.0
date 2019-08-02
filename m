Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67C0801EF
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2019 22:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437038AbfHBUrE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Aug 2019 16:47:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfHBUrD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Aug 2019 16:47:03 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hteS2-00018W-As; Fri, 02 Aug 2019 22:46:58 +0200
Date:   Fri, 2 Aug 2019 22:46:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Kara <jack@suse.cz>
cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH 0/7] jbd2: Bit spinlock conversions
In-Reply-To: <20190802151356.777-1-jack@suse.cz>
Message-ID: <alpine.DEB.2.21.1908022245510.4029@nanos.tec.linutronix.de>
References: <20190802151356.777-1-jack@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan,

On Fri, 2 Aug 2019, Jan Kara wrote:

> This series is derived from Thomas' series to get rid of bit spinlocks in
> buffer head code. These patches convert BH_State bit spinlock to an ordinary
> spinlock inside struct journal_head and somewhat reduce the critical section
> under BH_JournalHead bit spinlock so that it is fine for RT. 

Thanks a lot for cleaning this up!

> Motivation from original Thomas' series:
> 
> Bit spinlocks are problematic if PREEMPT_RT is enabled. They disable
> preemption, which is undesired for latency reasons and breaks when regular
> spinlocks are taken within the bit_spinlock locked region because regular
> spinlocks are converted to 'sleeping spinlocks' on RT.
> 
> Bit spinlocks are also not covered by lock debugging, e.g. lockdep. With
> the spinlock substitution in place, they can be exposed via a new config
> switch: CONFIG_DEBUG_BIT_SPINLOCKS.
> 
> WRT patch routing: Since these are non-trivial changes to JBD2 and independent
> of the rest of the series from Thomas, I think it would be safest to route
> them through ext4 tree where they get most testing. Thoughts?

Yes, there is no dependency, so feel free to route it through ext4.

Thanks,

	tglx
