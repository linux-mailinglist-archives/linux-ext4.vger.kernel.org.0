Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1170D303509
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jan 2021 06:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbhAZFdb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jan 2021 00:33:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:55934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbhAYMm0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 25 Jan 2021 07:42:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D529DAC45;
        Mon, 25 Jan 2021 12:41:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7B77F1E14BB; Mon, 25 Jan 2021 13:41:17 +0100 (CET)
Date:   Mon, 25 Jan 2021 13:41:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] make jbd2 debug switch per device
Message-ID: <20210125124117.GB1175@quack2.suse.cz>
References: <cover.1611287342.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611287342.git.brookxu@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 22-01-21 14:43:18, Chunguang Xu wrote:
> On a multi-disk machine, because jbd2 debugging switch is global, this
> confuses the logs of multiple disks. It is not easy to distinguish the
> logs of each disk and the amount of generated logs is very large. Or a
> separate debugging switch for each disk would be better, so that you
> can easily distinguish the logs of a certain disk. 
> 
> We can enable jbd2 debugging of a device in the following ways:
> echo X > /proc/fs/jbd2/sdX/jbd2_debug
> 
> But there is a small disadvantage here. Because the debugging switch is
> placed in the journal_t object, the log before the object is initialized
> will be lost. However, usually this will not have much impact on
> debugging.

OK, I didn't look at the series yet but I'm wondering: How are you using
jbd2 debugging? I mean obviously it isn't meant for production use but
rather for debugging JBD2 bugs so I'm kind of wondering in which case too
many messages matter.

And if the problem is that there's a problem with distinguishing messages
from multiple filesystems, then it would be perhaps more useful to add
journal identification to each message similarly as we do it with ext4
messages (likely by using journal->j_dev) - which is very simple to do
after your patches 3 and 4.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
