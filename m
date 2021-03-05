Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE46432ED48
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 15:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhCEOje (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 09:39:34 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47682 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231195AbhCEOjS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 09:39:18 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 125Ed3LZ025739
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 Mar 2021 09:39:03 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DF72915C3A88; Fri,  5 Mar 2021 09:39:02 -0500 (EST)
Date:   Fri, 5 Mar 2021 09:39:02 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhaolong Zhang <zhangzl2013@126.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix bh ref count on error paths
Message-ID: <YEJChkXfcN/HCD+Z@mit.edu>
References: <1614678151-70481-1-git-send-email-zhangzl2013@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614678151-70481-1-git-send-email-zhangzl2013@126.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 02, 2021 at 05:42:31PM +0800, Zhaolong Zhang wrote:
> __ext4_journalled_writepage should drop bhs' ref count on error paths
> 
> Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>

Thanks, applied.

				- Ted
