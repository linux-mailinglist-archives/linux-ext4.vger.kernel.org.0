Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B92C2DCB7E
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 04:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgLQDsK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 22:48:10 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43783 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727422AbgLQDsK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Dec 2020 22:48:10 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BH3lDxM026777
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 22:47:14 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A2A3A420280; Wed, 16 Dec 2020 22:47:13 -0500 (EST)
Date:   Wed, 16 Dec 2020 22:47:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 031/141] ext4: Fix fall-through warnings for Clang
Message-ID: <X9rUwUxA2sLzDqgz@mit.edu>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <03497331f088a938d7a728e7a689bd7953139429.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03497331f088a938d7a728e7a689bd7953139429.1605896059.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 20, 2020 at 12:28:32PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of just letting the code
> fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, applied.

					- Ted
