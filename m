Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C02D91493F4
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 09:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgAYICd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jan 2020 03:02:33 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58969 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbgAYICc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Jan 2020 03:02:32 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P82HFf032512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 03:02:19 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BC88542014A; Sat, 25 Jan 2020 03:02:16 -0500 (EST)
Date:   Sat, 25 Jan 2020 03:02:16 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.com,
        adilger.kernel@dilger.ca, liangyun2@huawei.com,
        luoshijie1@huawei.com
Subject: Re: [PATCH v3 4/4] jbd2: clean __jbd2_journal_abort_hard() and
 __journal_abort_soft()
Message-ID: <20200125080216.GL1108497@mit.edu>
References: <20191204124614.45424-1-yi.zhang@huawei.com>
 <20191204124614.45424-5-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204124614.45424-5-yi.zhang@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 04, 2019 at 08:46:14PM +0800, zhangyi (F) wrote:
> __jbd2_journal_abort_hard() has never been used, now we can merge
> __jbd2_journal_abort_hard() and __journal_abort_soft() these two
> functions into jbd2_journal_abort() and remove them.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Thanks, applied.

					- Ted
