Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D94D132812
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2019 07:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfFCFli (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jun 2019 01:41:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57912 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfFCFli (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Jun 2019 01:41:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E6E1B261FA4
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Marco Nelissen <marco.nelissen@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: which lower filesystems are actually supported?
Organization: Collabora
References: <CAH2+hP4Q3i4LdKL2Cz=1uWq0+JSD1RnzcdmicDtCeqEUqLo+hg@mail.gmail.com>
        <CAOQ4uxgPXBazE-g2v=T_vOvnr_f0ZHyKYZ4wvn7A3ePatZrhnQ@mail.gmail.com>
        <20190602180057.GA4865@mit.edu>
        <CAOQ4uxhbSc0nZ69ffJVfNgVnr=ahg+HetiXcZKMXA2nXKCabqA@mail.gmail.com>
Date:   Mon, 03 Jun 2019 01:41:33 -0400
In-Reply-To: <CAOQ4uxhbSc0nZ69ffJVfNgVnr=ahg+HetiXcZKMXA2nXKCabqA@mail.gmail.com>
        (Amir Goldstein's message of "Mon, 3 Jun 2019 02:18:25 +0300")
Message-ID: <85k1e39qeq.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Sun, Jun 2, 2019 at 9:01 PM Theodore Ts'o <tytso@mit.edu> wrote:
>>
>> On Sun, Jun 02, 2019 at 09:42:54AM +0300, Amir Goldstein wrote:
>> > [+cc ext4] Heads up on bug reports "Overlayfs fails to mount with ext4"
>> >
>> > On Sat, Jun 1, 2019 at 11:02 PM Marco Nelissen <marco.nelissen@gmail.com> wrote:
>> > >
>> > > According to the documentation, "The lower filesystem can be any filesystem
>> > > supported by Linux", however this appears to not actually be the case, since
>> > > using a vfat filesystem results in the mount command printing "mount:
>> > > wrong fs type, bad option, bad superblock on overlay, missing codepage or
>> > > helper program, or other error", with dmesg saying "overlayfs: filesystem on
>> > > '/boot' not supported".
>> > > (that's from ovl_mount_dir_noesc(), when ovl_dentry_weird() returns nonzero)
>> >
>> > Specifically for vfat it is weird because of
>> > dentry->d_flags & (DCACHE_OP_HASH | DCACHE_OP_COMPARE)
>> > because it is case insensitive.
>>
> [...]
>> >
>> > I am guessing when people start using case insensitive enabled ext4,
>> > this problem
>> > is going to surface, because the same ext4 (e.g. root fs) could be
>> > used for samba
>> > export (case insensitive) and docker storage (overlayfs).
>>
> [...]
>>
>> We *might* be able to only set the dentry functions on directory
>> entries belonging to directories which have the casefold flag set,
>> instead of simply setting it on all ext4 dentry entries.  But still
>> won't change the fact that overlayfs is going to have case
>> insensitivity support if we want the combination of overlayfs &&
>> casefold to be supported.
>>
>
> My intention was not that overlayfs should support casefold, just that
> an isolated casefold subdir in an ext4 fs shouldn't make the entire fs
> not usable with overlayfs.

That is a reasonable request.  I discussed a bit with Ted about how to
not set dentry functions filesystem wide,  because that gets in the way
of fscrypt.  I don't have a definite answer on how to do it, but it is
something that I will try to fix to enable fscrypt+casefold support.

> Incidentally, we already ran into a similar issue with ext4 encryption.
> Issue was reported by OpenWRT developers and fixed by:
> d456a33f041a fscrypt: only set dentry_operations on ciphertext dentries
>
> I recon casefold is taking a similar direction to the fs/crypto library, so
> solution should be similar as well.
>
> BTW, is casefold feature mutually exclusive with encryption feature?
> Because if it isn't, d_set_d_op() in __fscrypt_prepare_lookup() is
> going to WARN_ON dentry already has ext4_dentry_ops.

Not yet, and that is part of the reason. Right now, these two features
cannot be enable simultaneously, but it is on my todo list to support
that case.

> Thanks,
> Amir.

-- 
Gabriel Krisman Bertazi
