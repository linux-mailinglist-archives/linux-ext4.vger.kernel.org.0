Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0353430E7
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Mar 2021 05:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCUEoN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Mar 2021 00:44:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45632 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229870AbhCUEnx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 21 Mar 2021 00:43:53 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12L4hiJR017790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Mar 2021 00:43:45 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6DBC115C39CA; Sun, 21 Mar 2021 00:43:44 -0400 (EDT)
Date:   Sun, 21 Mar 2021 00:43:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pan Bian <bianpan2016@163.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: ext4: stop inode update before return
Message-ID: <YFbPADCUjfgL37Pz@mit.edu>
References: <20210117085732.93788-1-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117085732.93788-1-bianpan2016@163.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jan 17, 2021 at 12:57:32AM -0800, Pan Bian wrote:
> The inode update should be stopped before returing the error code.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Thanks, applied.

					- Ted
