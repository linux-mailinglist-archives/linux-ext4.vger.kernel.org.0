Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F093B314F
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jun 2021 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhFXOaU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Jun 2021 10:30:20 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52222 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230056AbhFXOaT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Jun 2021 10:30:19 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15OERjho002697
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 10:27:45 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 30DF115C3CD7; Thu, 24 Jun 2021 10:27:45 -0400 (EDT)
Date:   Thu, 24 Jun 2021 10:27:45 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     yangerkun <yangerkun@huawei.com>
Cc:     jack@suse.com, harshadshirwadkar@gmail.com,
        linux-ext4@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] jbd2: clean up misleading comments for
 jbd2_fc_release_bufs
Message-ID: <YNSWYb0+bvfjwPNR@mit.edu>
References: <20210608141236.459441-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608141236.459441-1-yangerkun@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 08, 2021 at 10:12:36PM +0800, yangerkun wrote:
> This comments was for jbd2_fc_wait_bufs, not for jbd2_fc_release_bufs.
> Remove this misleading comments.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Applied, thanks.

					- Ted
