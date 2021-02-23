Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16166322452
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Feb 2021 03:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhBWC6E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Feb 2021 21:58:04 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43808 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231196AbhBWC6E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Feb 2021 21:58:04 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11N2vEPB030740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 21:57:15 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5D7D415C342C; Mon, 22 Feb 2021 21:57:14 -0500 (EST)
Date:   Mon, 22 Feb 2021 21:57:14 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: Re: [PATCH] misc: replace remaining loff_t with ext2_loff_t
Message-ID: <YDRvCkPSayiAPHTi@mit.edu>
References: <20201212095823.35563-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212095823.35563-1-adilger@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 12, 2020 at 02:58:23AM -0700, Andreas Dilger wrote:
> From: Andreas Dilger <adilger@whamcloud.com>
> 
> Replace the remaining loff_t uses with ext2_loff_t, as
> was done in patch 1df6a4555, since loff_t is a GCC'ism
> and is not portable.
> 
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>

Thanks, applied.

					- Ted
