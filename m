Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6237C7A59A9
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 08:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjISGAS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 02:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjISGAS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 02:00:18 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A5FC
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 23:00:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VsQ8FCm_1695103205;
Received: from 30.221.134.16(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsQ8FCm_1695103205)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 14:00:05 +0800
Content-Type: multipart/mixed; boundary="------------0BvfEJZiAkTkop5u0YqIxKE0"
Message-ID: <02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com>
Date:   Tue, 19 Sep 2023 14:00:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@lst.de>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [bug report] ext4 misses final i_size meta sync under O_DIRECT |
 O_SYNC semantics after iomap DIO conversion
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------0BvfEJZiAkTkop5u0YqIxKE0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

Our consumer reports a behavior change between pre-iomap and iomap
direct io conversion:

If the system crashes after an appending write to a file open with
O_DIRECT | O_SYNC flag set, file i_size won't be updated even if
O_SYNC was marked before.

It can be reproduced by a test program in the attachment with
gcc -o repro repro.c && ./repro testfile && echo c > /proc/sysrq-trigger

After some analysis, we found that before iomap direct I/O conversion,
the timing was roughly (taking Linux 3.10 codebase as an example):

	..
	- ext4_file_dio_write
	  - __generic_file_aio_write
	      ..
	    - ext4_direct_IO  # generic_file_direct_write
	      - ext4_ext_direct_IO
	        - ext4_ind_direct_IO  # final_size > inode->i_size
	          - ..
	          - ret = blockdev_direct_IO()
	          - i_size_write(inode, end) # orphan && ret > 0 &&
	                                   # end > inode->i_size
	          - ext4_mark_inode_dirty()
	          - ...
	  - generic_write_sync  # handling O_SYNC

So the dirty inode meta will be committed into journal immediately
if O_SYNC is set.  However, After commit 569342dc2485 ("ext4: move
inode extension/truncate code out from ->iomap_end() callback"),
the new behavior seems as below:

	..
	- ext4_dio_write_iter
	  - ext4_dio_write_checks  # extend = 1
	  - iomap_dio_rw
	      - __iomap_dio_rw
	      - iomap_dio_complete
	        - generic_write_sync
	  - ext4_handle_inode_extension  # extend = 1

So that i_size will be recorded only after generic_write_sync() is
called.  So O_SYNC won't flush the update i_size to the disk.

On the other side, after a quick look of XFS side, it will record
i_size changes in xfs_dio_write_end_io() so it seems that it doesn't
have this problem.

Thanks,
Gao Xiang
--------------0BvfEJZiAkTkop5u0YqIxKE0
Content-Type: text/plain; charset=UTF-8; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzdGRp
by5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgojaW5j
bHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxsaW51eC9mcy5oPgojaW5jbHVkZSA8ZmNu
dGwuaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUg
PHN0cmluZy5oPgoKI2RlZmluZSBQQUdFX1NJWkUgNDA5NgoKaW50IHRlc3QoY2hhciogZmls
ZSkKewogICAgY2hhciogYnVmID0gTlVMTDsKICAgIGludCByZXQgPSAwOwogICAgaW50IGkg
PSAwOwogICAgcG9zaXhfbWVtYWxpZ24oKHZvaWQqKikoJmJ1ZiksIFBBR0VfU0laRSwgUEFH
RV9TSVpFKTsKICAgIG1lbXNldChidWYsIDAsIFBBR0VfU0laRSk7CiAgICBmb3IgKGkgPSAw
IDsgaSA8IFBBR0VfU0laRSA7ICsraSkgYnVmW2ldID0gaTsKICAgIGludCBmZCA9IG9wZW4o
ZmlsZSwgT19XUk9OTFl8T19DUkVBVHxPX0RJUkVDVHxPX1NZTkMpOwogICAgaWYgKGZkID09
IC0xKQogICAgewogICAgICAgIGZwcmludGYoc3RkZXJyLCAiJXM6ICVzXG4iLCBmaWxlLCBz
dHJlcnJvcihlcnJubykpOwogICAgICAgIGV4aXQoMSk7CiAgICB9CiAgICBzdHJ1Y3Qgc3Rh
dCBzdDsKICAgIHJldCA9IGZzdGF0KGZkLCAmc3QpOwogICAgaWYgKHJldCAhPSAwKQogICAg
ewogICAgICAgIGZwcmludGYoc3RkZXJyLCAiJXM6ICVzXG4iLCBmaWxlLCBzdHJlcnJvcihl
cnJubykpOwogICAgICAgIGV4aXQoMSk7CiAgICB9CiAgICBpbnQgb2Zmc2V0ID0gc3Quc3Rf
c2l6ZTsKICAgIHJldCA9IHB3cml0ZShmZCwgYnVmLCBQQUdFX1NJWkUsIG9mZnNldCk7CiAg
ICBpZiAocmV0ICE9IFBBR0VfU0laRSkKICAgIHsKICAgICAgICBmcHJpbnRmKHN0ZGVyciwg
IndyaXRlIGZhaWw6IHJldCAlZCAlc1xuIiwgcmV0LCBzdHJlcnJvcihlcnJubykpOwogICAg
fQogICAgY2xvc2UoZmQpOwogICAgcmV0dXJuIDA7Cn0KCmludCBtYWluKGludCBhcmdjLCBj
aGFyICoqIGFyZ3YpCnsKICAgIGludCByZXQgPSAwOwogICAgY2hhciBmaWxlWzEwMjRdID0g
e307CiAgICBpZiAoYXJnYyAhPSAyKQogICAgewogICAgICAgIGZwcmludGYoc3RkZXJyLCAi
dXNhZ2U6ICVzIHBhdGgtdG8td3JpdGVcbiIsIGFyZ3ZbMF0pOwogICAgICAgIGV4aXQoMik7
CiAgICB9CiAgICBzbnByaW50ZihmaWxlLCBzaXplb2YoZmlsZSksICIlc18lZCIsIGFyZ3Zb
MV0sIDApOwogICAgdGVzdChmaWxlKTsKICAgIHJldHVybiAwOwp9Cg==

--------------0BvfEJZiAkTkop5u0YqIxKE0--
