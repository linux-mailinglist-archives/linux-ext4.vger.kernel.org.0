Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6F43797AA
	for <lists+linux-ext4@lfdr.de>; Mon, 10 May 2021 21:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhEJTYf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 May 2021 15:24:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47924 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231601AbhEJTYe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 May 2021 15:24:34 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14AJNMFb014105
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 15:23:23 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8EF6015C3CD9; Mon, 10 May 2021 15:23:22 -0400 (EDT)
Date:   Mon, 10 May 2021 15:23:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/53] docs: filesystems: ext4: avoid using UTF-8 chars
Message-ID: <YJmIKtj+d9R5XA0X@mit.edu>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <9d8a6fdf5aec2dfa3e5ff459319c77698815f3d7.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d8a6fdf5aec2dfa3e5ff459319c77698815f3d7.1620641727.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 10, 2021 at 12:26:40PM +0200, Mauro Carvalho Chehab wrote:
> While UTF-8 characters can be used at the Linux documentation,
> the best is to use them only when ASCII doesn't offer a good replacement.
> So, replace the occurences of the following UTF-8 characters:
> 
> 	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
> 	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK
> 	- U+2217 ('∗'): ASTERISK OPERATOR
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>

Thanks,

					- Ted
