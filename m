Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C401D336C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgENOsG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 10:48:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58217 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbgENOsG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 May 2020 10:48:06 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04EEljIR005647
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 10:47:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A0760420304; Thu, 14 May 2020 10:47:45 -0400 (EDT)
Date:   Thu, 14 May 2020 10:47:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     adilger.kernel@dilger.ca, enwlinux@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove unnecessary comparisons to bool
Message-ID: <20200514144745.GS1596452@mit.edu>
References: <20200420042918.19459-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420042918.19459-1-yanaijie@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 20, 2020 at 12:29:18PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> fs/ext4/extents_status.c:1057:5-28: WARNING: Comparison to bool
> fs/ext4/inode.c:2314:18-24: WARNING: Comparison to bool
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied, thanks.

					- Ted
