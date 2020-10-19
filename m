Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F18529237F
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 10:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgJSITa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 04:19:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:32950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbgJSITa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Oct 2020 04:19:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C564ACF1;
        Mon, 19 Oct 2020 08:19:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A21D11E1340; Mon, 19 Oct 2020 10:19:27 +0200 (CEST)
Date:   Mon, 19 Oct 2020 10:19:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Anufriev <dotdot@yandex-team.ru>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH 2/2] ext4: export quota journalling mode via sysfs attr
 quota_mode
Message-ID: <20201019081927.GA30825@quack2.suse.cz>
References: <1602761572-4713-1-git-send-email-dotdot@yandex-team.ru>
 <1602761572-4713-2-git-send-email-dotdot@yandex-team.ru>
 <20201015131522.GF7037@quack2.suse.cz>
 <alpine.OSX.2.23.453.2010172056490.87244@dotdot-osx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.OSX.2.23.453.2010172056490.87244@dotdot-osx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 17-10-20 21:26:37, Roman Anufriev wrote:
> Hi, sorry for the delay.
> 
> On Thu, 15 Oct 2020, Jan Kara wrote:
> 
> > On Thu 15-10-20 14:32:52, Roman Anufriev wrote:
> > > Right now, it is hard to understand what quota journalling type is enabled:
> > > you need to be quite familiar with kernel code and trace it or really
> > > understand what different combinations of fs flags/mount options lead to.
> > > 
> > > This patch exports via sysfs attr /sys/fs/ext4/<disk>/quota_mode current
> > > quota jounalling mode, making it easier to check at a glance/in autotests.
> > > The semantics is similar to ext4 data journalling modes:
> > > 
> > > * journalled - quota accounting and journaling are enabled
> > > * writeback  - quota accounting is enabled, but journalling is disabled
> > > * none       - quota accounting is disabled
> > > * disabled   - kernel compiled without CONFIG_QUOTA feature
> > > 
> > > Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
> > > Reviewed-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> > 
> > Hum, I'm not sure about this. The state of quota can be found out with
> > "quotaon -p <mntpoint>" (or corresponding quotactl if you need this from
> > C). The only thing you won't learn is journalled / writeback mode and
> > generally you should not care about this although I agree that for fs
> > crash testing purposes you may care. But is that big enough usecase for a
> > new sysfs file when all the information is already available for userspace
> > just not in a convenient form?
> 
> Rationale behind this patch was mainly the addition of an easy way to check
> whether quota journalled or not as this is quite wanted feature in out
> production environment. TBH, I was not sure about sysfs file too, but it
> seemed to me like the most natural place to put it. Maybe if sysfs is an
> overkill - just add printing to dmesg on mount? At least, you'll be able to
> check what quota type you can enable right after mounting.
> 
> > BTW, I've now realized ext4_any_quota_enabled() has actually misleading
> > name in the sysfs file reports wrong information. It is rather
> > ext4_any_quota_may_be_enabled() since presence of QUOTA mount option only
> > says that quotaon(8) will enable quotas if it is run, not that quota
> > accounting is enabled. sb_any_quota_loaded() tells you if accounting is
> > actually enabled or not (however this can change anytime so that's why we
> > use more relaxed checks for the purpose of journal credit estimates).
> 
> My bad! Totally forgot about the case when 'quota' mount option is present
> but quota accounting is not enabled, as our helper-tool around 'quotactl()'
> do remounting+enabling in one go.
> 
> I'll rename the function to smth like 'ext4_quota_capable()' in v2. And if
> printing to dmesg is OK, I'll probably still use this function to print on
> mount what the quota type will be after accounting is enabled.

Yeah, if a message in dmesg is fine for your purposes, I'd rather go with
that than with a sysfs file.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
