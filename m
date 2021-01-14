Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7DD2F598C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jan 2021 04:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbhANDpv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jan 2021 22:45:51 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37802 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726152AbhANDpv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jan 2021 22:45:51 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10E3iwik019962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 22:44:58 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0CB1015C3453; Wed, 13 Jan 2021 22:44:58 -0500 (EST)
Date:   Wed, 13 Jan 2021 22:44:57 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Daejun Park <daejun7.park@samsung.com>
Cc:     "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "harshadshirwadkar@gmail.com" <harshadshirwadkar@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Remove expensive flush on fast commit
Message-ID: <X/++OfdtJSykRIeB@mit.edu>
References: <CGME20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
 <20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 06, 2021 at 10:32:42AM +0900, Daejun Park wrote:
> In the fast commit, it adds REQ_FUA and REQ_PREFLUSH on each fast commit
> block when barrier is enabled. However, in recovery phase, ext4 compares
> CRC value in the tail. So it is sufficient adds REQ_FUA and REQ_PREFLUSH
> on the block that has tail.
> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>

Thanks, applied.

					- Ted
