Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12EA65197A
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2019 19:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfFXRZ2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jun 2019 13:25:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39120 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726941AbfFXRZ2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jun 2019 13:25:28 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5OHPCFe025729
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 13:25:13 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9BDD442002B; Mon, 24 Jun 2019 13:25:12 -0400 (EDT)
Date:   Mon, 24 Jun 2019 13:25:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: Removing the shared class of tests
Message-ID: <20190624172512.GC6350@mit.edu>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
 <20190620112903.GF15846@desktop>
 <20190620162116.GA4650@mit.edu>
 <20190620175035.GA5380@magnolia>
 <20190624071610.GA10195@infradead.org>
 <20190624130730.GD1805@mit.edu>
 <20190624170515.GF5375@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624170515.GF5375@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 24, 2019 at 10:05:15AM -0700, Darrick J. Wong wrote:
> > shared/289 --- contains ext4, xfs, and btrfs mechanisms for
> > 	determining blocks which are unallocated.  Has hard-coded
> > 	invocations to dumpe2fs, xfs_db, and /bin/btrfs.
> 
> Huh?  shared/289 looks like a pure ext* test to me....

Sorry, typo.  That should have been shared/298.

I've already moved shared/289 to ext4 in my proposed patches to move
tests out of shared/.

				- Ted
