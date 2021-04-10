Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A23935A9EE
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Apr 2021 03:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhDJB3S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 21:29:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47732 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235201AbhDJB3R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 21:29:17 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13A1Sk5p011989
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 21:28:46 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1287E15C3B12; Fri,  9 Apr 2021 21:28:46 -0400 (EDT)
Date:   Fri, 9 Apr 2021 21:28:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Xu Yihang <xuyihang@huawei.com>
Cc:     adilger.kernel@dilger.ca, harshadshirwadkar@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext4: fix error return code in
 ext4_fc_perform_commit()
Message-ID: <YHD/TlnFk6mEKqvV@mit.edu>
References: <20210408070033.123047-1-xuyihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408070033.123047-1-xuyihang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 08, 2021 at 03:00:33PM +0800, Xu Yihang wrote:
> In case of if not ext4_fc_add_tlv branch, an error return code is missing.
> 
> Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Yihang <xuyihang@huawei.com>

Thanks, applied.

					- Ted
