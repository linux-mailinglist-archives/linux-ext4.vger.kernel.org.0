Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313011D3305
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgENOeZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 10:34:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56137 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbgENOeY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 May 2020 10:34:24 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04EEY9s1000736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 10:34:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 73C36420304; Thu, 14 May 2020 10:34:09 -0400 (EDT)
Date:   Thu, 14 May 2020 10:34:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, stable@kernel.org,
        syzbot+bca9799bf129256190da@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: reject mount options not supported when remounting
 in handle_mount_opt()
Message-ID: <20200514143409.GP1596452@mit.edu>
References: <to=00000000000098a5d505a34d1e48@google.com>
 <20200415174839.461347-1-tytso@mit.edu>
 <20200415202537.GA2309605@iweiny-DESK2.sc.intel.com>
 <20200415220752.GA5187@mit.edu>
 <20200416052352.GK2309605@iweiny-DESK2.sc.intel.com>
 <20200422161029.GD20756@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422161029.GD20756@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 22, 2020 at 06:10:29PM +0200, Jan Kara wrote:
> On Wed 15-04-20 22:23:52, Ira Weiny wrote:
> > On Wed, Apr 15, 2020 at 06:07:52PM -0400, Theodore Y. Ts'o wrote:
> > > On Wed, Apr 15, 2020 at 01:25:37PM -0700, Ira Weiny wrote:
> > > > This fundamentally changes the behavior from forcing the dax mode to be the
> > > > same across the remount to only failing if we are going from non-dax to dax,
> > > > adding -o dax on the remount?
> > > > 
> > > > But going from -o dax to 'not -o dax' would be ok?
> > > > 
> > > > FWIW after thinking about it some I _think_ it would be ok to allow the dax
> > > > mode to change on a remount and let the inodes in memory stay in the mode they
> > > > are at.  And newly loaded inodes would get the new mode...  Unfortunately
> > > > without the STATX patch I have proposed the user does not have any way of
> > > > knowing which files are in which mode.
> > > 
> > > We don't currently support mount -o nodax.
> > 
> > But we do support not supplying the option which means 'nodax' right?
> 
> Yeah, I second what Ira wrote. The new code does not seem to properly
> detect a case when enabled mount option is removed for remount and thus the
> feature would get disabled during remount as a result...

Sorry for not responding earlier.  The way ext4 remounting working is
not supplying an mount option which toggles a switch means that we
don't change its current setting.

For example, if you mount with, say dioread_nolock, if you don't
specify it when remounting, the current setting of dioread_nolock
remains the same.  If you want to change it, you need to specify the
mount option nodioread_nolock.  The change is true for discard vs
nodiscard, etc.

We currently don't have nodax at all, which means that once dax is
set, there is no way to unset the dax mount option.  This was
deliberate, because I was aware that the dax->no dax transition would
result in badness.

Cheers,

							- Ted
