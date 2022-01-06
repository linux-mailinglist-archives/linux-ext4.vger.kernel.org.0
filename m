Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154C1485FEE
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 05:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiAFElR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 23:41:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39421 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230283AbiAFElQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 23:41:16 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2064fAVj003396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 23:41:11 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8CFB215C00E1; Wed,  5 Jan 2022 23:41:10 -0500 (EST)
Date:   Wed, 5 Jan 2022 23:41:10 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     cgel.zte@gmail.com
Cc:     lczerner@redhat.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.xin16@zte.com.cn, zealci@zte.com.cn
Subject: Re: [PATCH resend] fs/ext4: use BUG_ON instead of if condition
 followed by BUG
Message-ID: <YdZy5hOnPKQasN4F@mit.edu>
References: <20211220102421.sggplg54ncsafcpi@work>
 <20211228073252.580296-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228073252.580296-1-xu.xin16@zte.com.cn>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 28, 2021 at 07:32:52AM +0000, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> BUG_ON would be better.
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal robot <zealci@zte.com.cn>
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>

Thanks, applied.

					- Ted
