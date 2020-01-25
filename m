Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CC21493E5
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 08:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgAYHZ0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jan 2020 02:25:26 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51968 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbgAYHZ0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Jan 2020 02:25:26 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P7PBos025562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 02:25:14 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2527942014A; Sat, 25 Jan 2020 02:25:11 -0500 (EST)
Date:   Sat, 25 Jan 2020 02:25:11 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH v2] ext4,jbd2: fix comment and code style
Message-ID: <20200125072511.GF1108497@mit.edu>
References: <20200123064325.36358-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123064325.36358-1-luoshijie1@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 23, 2020 at 01:43:25AM -0500, Shijie Luo wrote:
> Fix comment and remove unneccessary blank.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
