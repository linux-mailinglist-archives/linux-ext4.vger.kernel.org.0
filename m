Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D9A184920
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Mar 2020 15:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCMOTr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Mar 2020 10:19:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57018 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726528AbgCMOTq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Mar 2020 10:19:46 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02DEJc1W025673
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 10:19:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6AA70420E5E; Fri, 13 Mar 2020 10:19:38 -0400 (EDT)
Date:   Fri, 13 Mar 2020 10:19:38 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-ext4@vger.kernel.org, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 02/21] block: remove __bdevname
Message-ID: <20200313141938.GD225435@mit.edu>
References: <20200312151939.645254-1-hch@lst.de>
 <20200312151939.645254-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312151939.645254-3-hch@lst.de>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 12, 2020 at 04:19:20PM +0100, Christoph Hellwig wrote:
> There is no good reason for __bdevname to exist.  Just open code
> printing the string in the callers.  For three of them the format
> string can be trivially merged into existing printk statements,
> and in init/do_mounts.c we can at least do the scnprintf once at
> the start of the function, and unconditional of CONFIG_BLOCK to
> make the output for tiny configfs a little more helpful.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Theodore Ts'o <tytso@mit.edu> # for ext4
