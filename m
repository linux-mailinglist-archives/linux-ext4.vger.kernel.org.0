Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16CE485F85
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 05:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiAFEJG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 23:09:06 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36230 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229907AbiAFEJG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 23:09:06 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 206492Bq027864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 23:09:03 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3A0BB15C00E1; Wed,  5 Jan 2022 23:09:02 -0500 (EST)
Date:   Wed, 5 Jan 2022 23:09:02 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH] fs: ext4: remove duplicate includes
Message-ID: <YdZrXiDFqnISDlJQ@mit.edu>
References: <20211207090430.4612-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207090430.4612-1-guozhengkui@vivo.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 07, 2021 at 05:04:30PM +0800, Guo Zhengkui wrote:
> remove a duplicate "#include <linux/dax.h>".
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

I'm confused.  I can't find any kernel version for which this applies.
Both at HEAD, and for all of 5.x, there is only a single #include of
the linux/dax.h header file:

% for i in $(seq 0 15) ; do git show v5.$i:fs/ext4/inode.c | grep linux/dax.h | wc -l ; done

show that for 5.0..5.15, "linux/dax.h" only appears once in
fs/ext4/inode.c.

						- Ted
