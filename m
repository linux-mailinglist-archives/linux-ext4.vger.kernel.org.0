Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326363D398E
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jul 2021 13:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhGWKw7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Jul 2021 06:52:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56372 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233315AbhGWKw6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Jul 2021 06:52:58 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16NBXOCa017152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 07:33:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DD57515C37C0; Fri, 23 Jul 2021 07:33:23 -0400 (EDT)
Date:   Fri, 23 Jul 2021 07:33:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: remove conflict comment from __ext4_forget
Message-ID: <YPqpA6ElBkwUvD7i@mit.edu>
References: <20210714055940.1553705-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714055940.1553705-1-guoqing.jiang@linux.dev>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 14, 2021 at 01:59:40PM +0800, Guoqing Jiang wrote:
> From: Guoqing Jiang <jiangguoqing@kylinos.cn>
> 
> We do a bforget and return for no journal case, so let's remove this
> conflict comment.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>

Thanks, applied.

					- Ted
