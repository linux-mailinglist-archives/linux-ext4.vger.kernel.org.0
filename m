Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE99C162
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Aug 2019 05:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfHYDNJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Aug 2019 23:13:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34849 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728243AbfHYDNJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Aug 2019 23:13:09 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7P3Ch3k026346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Aug 2019 23:12:44 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 20B7742049E; Sat, 24 Aug 2019 23:12:43 -0400 (EDT)
Date:   Sat, 24 Aug 2019 23:12:43 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] jbd2: add missing tracepoint for reserved handle
Message-ID: <20190825031243.GA25396@mit.edu>
References: <20190815134446.28547-1-xiaoguang.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815134446.28547-1-xiaoguang.wang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 15, 2019 at 09:44:46PM +0800, Xiaoguang Wang wrote:
> This issue was found when I use ebpf to trace every jbd2
> handle's running info in dioread_nolock case.
> 
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>

Thanks, applied.

						- Ted
