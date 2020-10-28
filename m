Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF92629D2BA
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Oct 2020 22:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgJ1VeY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 17:34:24 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56723 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbgJ1VeX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Oct 2020 17:34:23 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09SFtfd9024263
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 11:55:41 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 340BF420107; Wed, 28 Oct 2020 11:55:41 -0400 (EDT)
Date:   Wed, 28 Oct 2020 11:55:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ext4: use IS_ERR() for error checking of path
Message-ID: <20201028155541.GR5691@mit.edu>
References: <20201027204342.2794949-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027204342.2794949-1-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 27, 2020 at 01:43:42PM -0700, Harshad Shirwadkar wrote:
> With this fix, fast commit recovery code uses IS_ERR() for path
> returned by ext4_find_extent.
> 
> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks, applied.

				- Ted
