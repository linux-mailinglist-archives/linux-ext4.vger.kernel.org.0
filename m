Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD8E1D5DC2
	for <lists+linux-ext4@lfdr.de>; Sat, 16 May 2020 03:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgEPBuA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 May 2020 21:50:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:28415 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgEPBuA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 15 May 2020 21:50:00 -0400
IronPort-SDR: FSvUIo4HGT351WtWP8nBsbKV490bW2bD8y5ROqOft0OzWlZlOwlnSu37/u5cyB9RMOU5hOHntn
 iaVRuLh2O+tQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 18:49:59 -0700
IronPort-SDR: +44OKSQD30T2ErgR+ws3Jaw+vBaqnkiU8aZPbEkNGE7l20WRYduBUf+EXxf1E4gpNYRdHxsoRa
 i7mmZiYA8n/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,397,1583222400"; 
   d="scan'208";a="252208031"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga007.jf.intel.com with ESMTP; 15 May 2020 18:49:59 -0700
Date:   Fri, 15 May 2020 18:49:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, stable@kernel.org,
        syzbot+bca9799bf129256190da@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: reject mount options not supported when remounting
 in handle_mount_opt()
Message-ID: <20200516014958.GB3018416@iweiny-DESK2.sc.intel.com>
References: <to=00000000000098a5d505a34d1e48@google.com>
 <20200415174839.461347-1-tytso@mit.edu>
 <20200415202537.GA2309605@iweiny-DESK2.sc.intel.com>
 <20200415220752.GA5187@mit.edu>
 <20200416052352.GK2309605@iweiny-DESK2.sc.intel.com>
 <20200422161029.GD20756@quack2.suse.cz>
 <20200514143409.GP1596452@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514143409.GP1596452@mit.edu>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 14, 2020 at 10:34:09AM -0400, Theodore Y. Ts'o wrote:
> On Wed, Apr 22, 2020 at 06:10:29PM +0200, Jan Kara wrote:
> > On Wed 15-04-20 22:23:52, Ira Weiny wrote:
> > > On Wed, Apr 15, 2020 at 06:07:52PM -0400, Theodore Y. Ts'o wrote:
> > > > On Wed, Apr 15, 2020 at 01:25:37PM -0700, Ira Weiny wrote:
> > > > > This fundamentally changes the behavior from forcing the dax mode to be the
> > > > > same across the remount to only failing if we are going from non-dax to dax,
> > > > > adding -o dax on the remount?
> > > > > 
> > > > > But going from -o dax to 'not -o dax' would be ok?
> > > > > 
> > > > > FWIW after thinking about it some I _think_ it would be ok to allow the dax
> > > > > mode to change on a remount and let the inodes in memory stay in the mode they
> > > > > are at.  And newly loaded inodes would get the new mode...  Unfortunately
> > > > > without the STATX patch I have proposed the user does not have any way of
> > > > > knowing which files are in which mode.
> > > > 
> > > > We don't currently support mount -o nodax.
> > > 
> > > But we do support not supplying the option which means 'nodax' right?
> > 
> > Yeah, I second what Ira wrote. The new code does not seem to properly
> > detect a case when enabled mount option is removed for remount and thus the
> > feature would get disabled during remount as a result...
> 
> Sorry for not responding earlier.  The way ext4 remounting working is
> not supplying an mount option which toggles a switch means that we
> don't change its current setting.
> 
> For example, if you mount with, say dioread_nolock, if you don't
> specify it when remounting, the current setting of dioread_nolock
> remains the same.  If you want to change it, you need to specify the
> mount option nodioread_nolock.  The change is true for discard vs
> nodiscard, etc.
> 
> We currently don't have nodax at all, which means that once dax is
> set, there is no way to unset the dax mount option.  This was
> deliberate, because I was aware that the dax->no dax transition would
> result in badness.

At this point I'm not sure if it was working correctly before or not.

I did keep this thread in mind and did a bit more testing on the latest version
of the new DAX mount option parsing[1].

I have verified that whatever state (always, never, inode) dax was in, a
remount does not affect it and the warning is printed.

Furthermore I think the lead patches disabling verity and encryption[2] in that
series should help, if not fix, this bug.

Ted, do you think this series can make 5.8?  The prelim patches [2] could be
marked stable if you think they help without the rework of the mount option.

Thanks,
Ira

[1] https://lore.kernel.org/lkml/20200515093224.GI9569@quack2.suse.cz/
[2] https://lore.kernel.org/lkml/20200515044121.2987940-3-ira.weiny@intel.com/
    https://lore.kernel.org/lkml/20200515044121.2987940-4-ira.weiny@intel.com/

