Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8578F2BDCF
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 05:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfE1DkN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 May 2019 23:40:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49020 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727320AbfE1DkN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 May 2019 23:40:13 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4S3e7jc019180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 May 2019 23:40:07 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 26411420481; Mon, 27 May 2019 23:40:07 -0400 (EDT)
Date:   Mon, 27 May 2019 23:40:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: fsync_mode mount option for ext4
Message-ID: <20190528034007.GA19149@mit.edu>
References: <20190528032257.GF10043@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528032257.GF10043@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 28, 2019 at 08:52:57AM +0530, Sahitya Tummala wrote:
> Hi Ted, Andreas,
> 
> Do you think this mount option "fsync_mode=nobarrier"
> can be added for EXT4 as well like in F2FS? Please
> share your thoughts on this.
> 
> https://lore.kernel.org/patchwork/patch/908934/

Ext4 already has the nobarrier mount option.

Cheers,

     	     	     	       	     - Ted
