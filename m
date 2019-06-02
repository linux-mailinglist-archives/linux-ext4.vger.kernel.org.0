Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 539C332483
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Jun 2019 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFBSBN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 2 Jun 2019 14:01:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43234 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726170AbfFBSBM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 2 Jun 2019 14:01:12 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x52I0w4O013375
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 2 Jun 2019 14:00:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 10303420481; Sun,  2 Jun 2019 14:00:58 -0400 (EDT)
Date:   Sun, 2 Jun 2019 14:00:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Marco Nelissen <marco.nelissen@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: which lower filesystems are actually supported?
Message-ID: <20190602180057.GA4865@mit.edu>
References: <CAH2+hP4Q3i4LdKL2Cz=1uWq0+JSD1RnzcdmicDtCeqEUqLo+hg@mail.gmail.com>
 <CAOQ4uxgPXBazE-g2v=T_vOvnr_f0ZHyKYZ4wvn7A3ePatZrhnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgPXBazE-g2v=T_vOvnr_f0ZHyKYZ4wvn7A3ePatZrhnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 02, 2019 at 09:42:54AM +0300, Amir Goldstein wrote:
> [+cc ext4] Heads up on bug reports "Overlayfs fails to mount with ext4"
> 
> On Sat, Jun 1, 2019 at 11:02 PM Marco Nelissen <marco.nelissen@gmail.com> wrote:
> >
> > According to the documentation, "The lower filesystem can be any filesystem
> > supported by Linux", however this appears to not actually be the case, since
> > using a vfat filesystem results in the mount command printing "mount:
> > wrong fs type, bad option, bad superblock on overlay, missing codepage or
> > helper program, or other error", with dmesg saying "overlayfs: filesystem on
> > '/boot' not supported".
> > (that's from ovl_mount_dir_noesc(), when ovl_dentry_weird() returns nonzero)
> 
> Specifically for vfat it is weird because of
> dentry->d_flags & (DCACHE_OP_HASH | DCACHE_OP_COMPARE)
> because it is case insensitive.

Marco, did you actually *need* to use the case insensitive feature?
It is not turned on by default by e2fsprogs, and the assumption was
that it only be turned in cases where it was needed --- e.g., VM's
running Steam games that need Microsoft file system semantics,
including case insensitivity, Samba (and eventually NFSv4) file
servers for the same reason, and Android (so people won't have to try
to get the abomination known as sdcardfs upstream :-).

> 
> I am guessing when people start using case insensitive enabled ext4,
> this problem
> is going to surface, because the same ext4 (e.g. root fs) could be
> used for samba
> export (case insensitive) and docker storage (overlayfs).

So I didn't think this would be that common, since you can certainly
run Sambda without this new file system feature --- Samba has lived
without it for over a decade.  However, if you are running a high
performance file server, it matters --- but if you're running a high
performance file server, you're certainly not going to be trying to do
it on the same server as one running Docker.

Now, if you're trying to use overlayfs for some kind of snapshot
application, then we'll need to figure out how to make overlayfs and
ext4 work together --- but I view this as much more over an overlay
compatibility issue than an ext4 bug.

We *might* be able to only set the dentry functions on directory
entries belonging to directories which have the casefold flag set,
instead of simply setting it on all ext4 dentry entries.  But still
won't change the fact that overlayfs is going to have case
insensitivity support if we want the combination of overlayfs &&
casefold to be supported.

> I didn't see that xfstests-bld was updated with case folding configs for ext4,
> nor that xfstests has any new case folding tests (saw some posted), so I guess
> that is still in the works (?).

That's correct, it's still on the todo list.

> Did you happen to try out overlayfs/docker over a case insensitive enabled fs?

Nope.  I didn't think that was going to be a common use case.  Docker
is typically used on servers, where as case insensitivity is important
for clients and file servers --- at least on the general case.

> I wonder if you could spare a few extra GCE instances per pre-release tests
> to run an overlay over ext4 config?
> I was nagging Darrick about this for a while and now I think the
> overlay/xfs config
> is being tested regularly.

It wouldn't be that hard to test overlayfs with ext4 for my
pre-release testing.  But it would only be in the default ext4
configuration --- and that doesn't include the case fold feature.

	      	      	   	   	   - Ted
