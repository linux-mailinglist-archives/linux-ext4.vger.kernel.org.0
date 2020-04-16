Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B033A1AB733
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Apr 2020 07:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406337AbgDPFXz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Apr 2020 01:23:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:6837 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405910AbgDPFXx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 Apr 2020 01:23:53 -0400
IronPort-SDR: FK3thNlWBt6+WeqlTTXai4I0xWy1ke8jWz5WVN+VpZMp9NDSjvikiGodOsIgNpASNLl3INaTIe
 ATbARqIo2uwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 22:23:52 -0700
IronPort-SDR: rkCDxqxZmGSqcrVnf5Ntz9YJRC2ApVIcAvDj/Ck5gP0nfv9pEoOzL//5n+GVxKipAlQ9NV6SEM
 JME5fDDhl1+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="299200879"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2020 22:23:52 -0700
Date:   Wed, 15 Apr 2020 22:23:52 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, stable@kernel.org,
        syzbot+bca9799bf129256190da@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: reject mount options not supported when remounting
 in handle_mount_opt()
Message-ID: <20200416052352.GK2309605@iweiny-DESK2.sc.intel.com>
References: <to=00000000000098a5d505a34d1e48@google.com>
 <20200415174839.461347-1-tytso@mit.edu>
 <20200415202537.GA2309605@iweiny-DESK2.sc.intel.com>
 <20200415220752.GA5187@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415220752.GA5187@mit.edu>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 15, 2020 at 06:07:52PM -0400, Theodore Y. Ts'o wrote:
> On Wed, Apr 15, 2020 at 01:25:37PM -0700, Ira Weiny wrote:
> > This fundamentally changes the behavior from forcing the dax mode to be the
> > same across the remount to only failing if we are going from non-dax to dax,
> > adding -o dax on the remount?
> > 
> > But going from -o dax to 'not -o dax' would be ok?
> > 
> > FWIW after thinking about it some I _think_ it would be ok to allow the dax
> > mode to change on a remount and let the inodes in memory stay in the mode they
> > are at.  And newly loaded inodes would get the new mode...  Unfortunately
> > without the STATX patch I have proposed the user does not have any way of
> > knowing which files are in which mode.
> 
> We don't currently support mount -o nodax.

But we do support not supplying the option which means 'nodax' right?

> So the intention of the
> current code is that the dax mode can't change in either direction
> (enabling or disabling) as a remount option.
> 
> The syzkaller report was because changing dax mode racing with other
> operations given the current code base, could result in a kernel OOPS.
> So we *do* need to rule it out at least for now.

But does this new patch prevent a dax change from '-o dax' to not specifying
the option?  I admit this option parsing code is confusing me.  So I might be
missing it completely.

> 
> I certainly don't object to allowing changing dax mode as a remount
> --- so long as we have tests to make sure that if we stress opening,
> reading, writing, mmap'ing files, etc., while another thread is
> flipping back and forth between dax=never and dax=always is mount -o
> remount --- and make sure that we don't end up crashing.
> 
> And this test needs to be in xfstests, because trying to figure out
> what triggers a syzkaller failures in file system land is a pain in
> the *ss so we really want a dedicated xfstests for this case.

Agreed.

> Have
> you tested your patch series to make sure we don't have some potential
> races here?

No,  I've not anticipated the potential of this until today...  :-D

Ira

