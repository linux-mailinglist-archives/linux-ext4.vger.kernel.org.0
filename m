Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26DA183460
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgCLPTn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:19:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgCLPTm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b3RXsv2Nj0w6mo5snr4nzMkxAesLBKH5E0NpaP9zKiw=; b=R1rpb4mbwYVS0YcV9SIkvfKlEB
        /ixd3jBPhHxBkidFliarHs2e+ag+JOZdBakRJ1MnrtGIOO1ih/twSwfNek1+uEy5g49lhNi1l1L3q
        6KT+Jt7IVTb1IqCHVrYX2Ee5q14/P1opgCesbnkWxyK1hQ9RFgws8cOT5Qsl8t8uK4PtNnr59y/iA
        rKO/cBNsIlODPpSjvU5A0JB2+QozpJoo0xy62UHTJo6WJsxPSscEJlY8TXzPXHmBH6dvaRJPDuuMe
        qmEiEKtKJ6LH2b5NJn49+o4VrVU9HyNFhKdk3olY0kvEugeOTqNJEXNho6yxAxPRdavm6rXbpQ4qB
        Khat2zog==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPcb-0006UB-SI; Thu, 12 Mar 2020 15:19:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: cleanup the partitioning code
Date:   Thu, 12 Mar 2020 16:19:18 +0100
Message-Id: <20200312151939.645254-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jens,

this series cleans up the partitioning code.
