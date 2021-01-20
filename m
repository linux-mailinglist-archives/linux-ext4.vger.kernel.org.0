Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E572FCA12
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jan 2021 05:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbhATEpC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Jan 2021 23:45:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38861 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727088AbhATEo7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Jan 2021 23:44:59 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10K4i1xe017737
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 23:44:02 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B7B0915C35F5; Tue, 19 Jan 2021 23:44:01 -0500 (EST)
Date:   Tue, 19 Jan 2021 23:44:01 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] filefrag: handle invalid st_dev and blksize cases
Message-ID: <YAe1EYzFWWxAK2I/@mit.edu>
References: <20201028155550.24680-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028155550.24680-1-lhenriques@suse.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 28, 2020 at 03:55:50PM +0000, Luis Henriques wrote:
> It is possible to crash filefrag with a "Floating point exception" in
> two different scenarios:
> 
> 1. When fstat() returns a device ID set to 0
> 2. When FIGETBSZ ioctl returns a blocksize of 0
> 
> In both scenarios a divide-by-zero will occur in frag_report() because
> variable blksize will be set to zero.
> 
> I've managed to trigger this crash with an old CephFS kernel client,
> using xfstest generic/519.  The first scenario has been fixed by kernel
> commit 75c9627efb72 ("ceph: map snapid to anonymous bdev ID").  The
> second scenario is also fixed with commit 8f97d1e99149 ("vfs: fix
> FIGETBSZ ioctl on an overlayfs file").
> 
> However, it is desirable to handle these two scenarios gracefully by
> checking these conditions explicitly.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.de>

Thanks, applied.

					- Ted
