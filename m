Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D99F2493B0
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 05:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHSD4J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 23:56:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45354 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726342AbgHSD4J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 23:56:09 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07J3nYCP011493
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 23:49:36 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9404A420DC0; Tue, 18 Aug 2020 23:49:34 -0400 (EDT)
Date:   Tue, 18 Aug 2020 23:49:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH v3] ext4: fix log printing of ext4_mb_regular_allocator()
Message-ID: <20200819034934.GE162457@mit.edu>
References: <0a165ac0-1912-aebd-8a0d-b42e7cd1aea1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a165ac0-1912-aebd-8a0d-b42e7cd1aea1@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Aug 15, 2020 at 08:10:44AM +0800, brookxu wrote:
> Fix log printing of ext4_mb_regular_allocator()，it may be an
> unintentional behavior.

Thanks, applied with Andreas's suggested improvement and with a
reworded commit description.

					- Ted
