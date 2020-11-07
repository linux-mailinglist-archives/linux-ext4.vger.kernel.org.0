Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635292AA24E
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 04:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgKGDZm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Nov 2020 22:25:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38360 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727298AbgKGDZm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Nov 2020 22:25:42 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0A73PP8L003828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Nov 2020 22:25:26 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5C2CD420107; Fri,  6 Nov 2020 22:25:25 -0500 (EST)
Date:   Fri, 6 Nov 2020 22:25:25 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add missing file in ext4 entry
Message-ID: <20201107032525.GA2499342@mit.edu>
References: <20201030022435.1136-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030022435.1136-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 30, 2020 at 10:24:35AM +0800, Chao Yu wrote:
> include/trace/events/ext4.h belongs to ext4 module, add the file path into
> ext4 entry in MAINTAINERS.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Thanks, applied.

					- Ted
