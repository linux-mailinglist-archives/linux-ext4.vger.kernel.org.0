Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AC42CF397
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 19:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbgLDSGm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 13:06:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46604 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727707AbgLDSGm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 13:06:42 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B4I5fFY004972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Dec 2020 13:05:42 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5811F420136; Fri,  4 Dec 2020 13:05:41 -0500 (EST)
Date:   Fri, 4 Dec 2020 13:05:41 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4: Funny characters appended to file names
Message-ID: <20201204180541.GC577125@mit.edu>
References: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
 <20201204152802.GQ441757@mit.edu>
 <93fab357-5ed2-403d-3371-6580aedecaf4@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93fab357-5ed2-403d-3371-6580aedecaf4@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 04, 2020 at 04:39:12PM +0100, Paul Menzel wrote:
> 
> > $ sudo LANG=C fsck.ext4 -f /dev/md0
> > e2fsck 1.45.6 (20-Mar-2020)
> > Pass 1: Checking inodes, blocks, and sizes
> > Pass 2: Checking directory structure
> > Pass 3: Checking directory connectivity
> > Pass 4: Checking reference counts
> > Pass 5: Checking group summary information
> > boot: 327/124928 files (17.7% non-contiguous), 126021/497856 blocks
> 
> I can’t remember if that was an Ext2 or Ext3 when created several years ago.

Well, the output dumpe2fs will tell us an awful lot about the file
system.

Whe was the last time the directory was OK?  Do you know when it may
have gotten corrupted?

				- Ted
