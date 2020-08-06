Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C723DFD2
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 19:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgHFRx5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 13:53:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40793 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728318AbgHFQaz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 12:30:55 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 076EgIUn002480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 10:42:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EDFF5420263; Thu,  6 Aug 2020 10:42:17 -0400 (EDT)
Date:   Thu, 6 Aug 2020 10:42:17 -0400
From:   tytso@mit.edu
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     <linux-ext4@vger.kernel.org>, <jack@suse.cz>,
        <riteshh@linux.ibm.com>
Subject: Re: [PATCH v2] ext4: remove some redundant function declarations
Message-ID: <20200806144217.GO7657@mit.edu>
References: <20200724032954.22097-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724032954.22097-1-luoshijie1@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 23, 2020 at 11:29:54PM -0400, Shijie Luo wrote:
> ext4 update feature functions do not exist now, remove these useless
> function declarations.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks, applied.

					- Ted
