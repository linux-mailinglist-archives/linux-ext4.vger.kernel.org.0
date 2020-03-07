Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3817CF47
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Mar 2020 17:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGQRK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Mar 2020 11:17:10 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46759 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbgCGQRJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Mar 2020 11:17:09 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 027GH5wc020488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Mar 2020 11:17:06 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 73A9B42045B; Sat,  7 Mar 2020 11:17:05 -0500 (EST)
Date:   Sat, 7 Mar 2020 11:17:05 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] libext2fs: don't use O_DIRECT for files on tmpfs
Message-ID: <20200307161705.GA99899@mit.edu>
References: <20200221214056.39993-1-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221214056.39993-1-adilger@whamcloud.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 21, 2020 at 02:40:56PM -0700, Andreas Dilger wrote:
> If a filesystem image is on tmpfs, opening it with O_DIRECT for
> reading the MMP will fail.  This is unnecessary, since the image
> file can't really be open on another node at this point.  If the
> open with O_DIRECT fails, retry without it when plausible.
> 
> Remove the special-casing of tmpfs from the mmp test cases.
> 
> Change-Id: I41f4b31657b06f62f10be8d6e524d303dd36a321
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>

Applied, thanks.

					- Ted
