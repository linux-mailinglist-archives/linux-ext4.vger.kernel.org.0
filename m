Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3861DD3F89
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2019 14:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfJKMbN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Oct 2019 08:31:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60622 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfJKMbN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Oct 2019 08:31:13 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iIu4Z-00008T-5V; Fri, 11 Oct 2019 14:31:07 +0200
Date:   Fri, 11 Oct 2019 14:31:07 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH 0/7 v2] jbd2: Bit spinlock conversions
Message-ID: <20191011123105.s6qjwrlgugszk73j@linutronix.de>
References: <20190809124233.13277-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190809124233.13277-1-jack@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019-08-09 14:42:26 [+0200], Jan Kara wrote:
> Hello,
Hi,

> This series is derived from Thomas' series to get rid of bit spinlocks in
> buffer head code. These patches convert BH_State bit spinlock to an ordinary
> spinlock inside struct journal_head and somewhat reduce the critical section
> under BH_JournalHead bit spinlock so that it is fine for RT. 
> 
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
> Ted, can you pick up these patches? Thanks!

Has this series been postponed?

> Changes since v1:
> * Fixed up compilation breakage on UP due to missing linux/spinlock.h include
> 
> 								Honza

Sebastian
