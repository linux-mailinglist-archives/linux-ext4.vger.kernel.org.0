Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B9636877F
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Apr 2021 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhDVT7C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Apr 2021 15:59:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40232 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236058AbhDVT7B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Apr 2021 15:59:01 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13MJwJbJ014299
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 15:58:20 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A2CFA15C3B0D; Thu, 22 Apr 2021 15:58:19 -0400 (EDT)
Date:   Thu, 22 Apr 2021 15:58:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] ext4: wipe filename upon file deletion
Message-ID: <YIHVWySvaECveV4l@mit.edu>
References: <20210419162100.1284475-1-leah.rumancik@gmail.com>
 <YH4KAHWphO+0xubA@gmail.com>
 <YH41aghszkzcwdDx@mit.edu>
 <3D2D6626-DF0A-4476-AD2D-8E43477A6176@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D2D6626-DF0A-4476-AD2D-8E43477A6176@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 22, 2021 at 11:44:49AM -0600, Andreas Dilger wrote:
> Since the "delete-after-the-fact" method of security is always going
> to have holes in terms of recovering data from the journal, from the
> flash device, etc. why not use fscrypt for this kind of workload, if
> the data actually needs to be secure?

Wiping the journal is something that will be coming soon --- prototype
versions of that patch have been sent out, and the main controversy
has been whether it should be an ext4-specific interface, or whether
it should be done in a file system independent API, and if so, how to
define it.

Whether or not you can recover it from the block device is very block
device specific.  There are certainly situations, such as people
running VM's on AWS, Azure, GCP, etc., where they don't have physical
access to the block device, where making sure it can be wiped so it
can't be accessed via software is quite sufficient.  Even if you have
physical access to block device, recovering overwritten information
from a HDD is *not* trivial.  Not all adversaries have access to
scanning electronic microscopes, and demonstrations that overwritten
disk sectors were done decades ago, when the magnetic domains were far
larger.

Using fscrypt is certainly an option, but using encryption is not free
from a performance standpoint, and you still have to answer the
question of where the encryption keys would be stored.

Cheers,

					- Ted

P.S.  Interesting info from
https://security.stackexchange.com/questions/26132/is-data-remanence-a-myth:

    The best citation I can give is from Overwriting Hard Drive Data: The
    Great Wiping Controversy, which was published as part of the 4th
    International Conference on Information Systems Security, ICISS
    2008. You can view the full text of the paper by viewing the book on
    Google Books, and jumping to page 243.

    The following excerpt is from their conclusion:

        The purpose of this paper was a categorical settlement to the
        controversy surrounding the misconceptions involving the belief that
        data can be recovered following a wipe procedure. This study has
        demonstrated that correctly wiped data cannot reasonably retrieved
        even if it of a small size or found only over small parts of the hard
        drive. Not even with the use of a MFM or other known methods. The
        belief that a tool can be developed to retrieve gigabytes or terabytes
        of data of information from a wiped drive is in error.

        Although there is a good chance of recovery for any individual bit
        from a drive, the chance of recovery of any amount of data from a
        drive using an electron microscope are negligible. Even speculating on
        the possible recovery of an old drive, there is no likelihood that any
        data would be recoverable from the drive. The forensic recovery of
        data using electron microscopy is infeasible. This was true both on
        old drives and has become more difficult over tine. Further, there is
        a need for the data to have been written and then wiped on a raw
        unused drive for there to be any hopy of any level of recovery even at
        the bit level, which does not reflect real situations. It is unlikely
        that a recovered drive will have not been used for a period of time
        and the interaction of defragmentation, file copies and general use
        that overwrites data areas negates any chance of data recovery. The
        fallacy that data can be forensically recovered using an electron
        microscope or related means needs to be put to rest.

    NIST also seem to agree. In NIST SP 800-88, they state the following:

        Studies have shown that most of today’s media can be effectively
        cleared by one overwrite.

        Purging information is a media sanitization process that protects the
        confidentiality of information against a laboratory attack. For some
        media, clearing media would not suffice for purging. However, for ATA
        disk drives manufactured after 2001 (over 15 GB) the terms clearing
        and purging have converged.
