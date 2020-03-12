Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A54191833F5
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgCLPA3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:00:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50941 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727489AbgCLPA3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:00:29 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02CF0Oll020674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 11:00:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4EED4420E5E; Thu, 12 Mar 2020 11:00:24 -0400 (EDT)
Date:   Thu, 12 Mar 2020 11:00:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: remove map_from_cluster from ext4_ext_map_blocks
Message-ID: <20200312150024.GK7159@mit.edu>
References: <20200311205125.25061-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311205125.25061-1-enwlinux@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 11, 2020 at 04:51:25PM -0400, Eric Whitney wrote:
> We can use the variable allocated_clusters rather than map_from_clusters
> to control reserved block/cluster accounting in ext4_ext_map_blocks.
> This eliminates a variable and associated code and improves readability
> a little.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Applied, thanks.

							- Ted
