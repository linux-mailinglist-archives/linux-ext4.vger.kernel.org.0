Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A881493E3
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 08:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgAYHYA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jan 2020 02:24:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51706 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726470AbgAYHYA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Jan 2020 02:24:00 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P7Nh8X025287
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 02:23:46 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C8B3842014A; Sat, 25 Jan 2020 02:23:42 -0500 (EST)
Date:   Sat, 25 Jan 2020 02:23:42 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     wangyan <wangyan122@huawei.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: delete the duplicated words in the comments
Message-ID: <20200125072342.GE1108497@mit.edu>
References: <12087f77-ab4d-c7ba-53b4-893dbf0026f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12087f77-ab4d-c7ba-53b4-893dbf0026f0@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 22, 2020 at 05:33:10PM +0800, wangyan wrote:
> Delete the duplicated words "is" in the comments
> 
> Signed-off-by: Yan Wang <wangyan122@huawei.com>

Thanks, applied.

					- Ted
