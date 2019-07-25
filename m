Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA5474419
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2019 05:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390113AbfGYDq7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jul 2019 23:46:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38480 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389014AbfGYDq7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Jul 2019 23:46:59 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6P3kpV2022506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jul 2019 23:46:51 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D1D6A4202F5; Wed, 24 Jul 2019 23:46:50 -0400 (EDT)
Date:   Wed, 24 Jul 2019 23:46:50 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 01/11] ext4: add handling for extended mount options
Message-ID: <20190725034650.GC13651@mit.edu>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
 <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca>
 <20190722210235.GE16313@mit.edu>
 <7AD1A611-9BD2-4F32-9568-D0A517047EF0@dilger.ca>
 <CAD+ocbwCYZDrj9D=85AVaB_RLYjUFwNs1V02fRn4tHh04_k7_A@mail.gmail.com>
 <20190724061231.GA7074@magnolia>
 <20190724160749.GF4565@mit.edu>
 <20190724165637.GB7074@magnolia>
 <CAD+ocbyeT7kmwfC-ixwdAr-ErRF3WQA6+BDSMTmUSL7QQSEugg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbyeT7kmwfC-ixwdAr-ErRF3WQA6+BDSMTmUSL7QQSEugg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 24, 2019 at 11:14:39AM -0700, harshad shirwadkar wrote:
> I agree, I was going to suggest the same. We would probably need to
> add this field in all individual fast commit blocks, since we don't
> have a fast commit superblock equivalent .. and changing jbd2
> superblock is probably too much to ask for I guess.

There's spare space in the jbd2 superblock.  Just grab a byte from
s_padding2...

					- Ted
