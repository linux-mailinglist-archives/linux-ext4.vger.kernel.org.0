Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5081B6C45F4
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 10:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjCVJPD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Mar 2023 05:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjCVJOz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Mar 2023 05:14:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2861A5CC3A;
        Wed, 22 Mar 2023 02:14:48 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DNt-1pe5WZ3vkT-003eDo; Wed, 22
 Mar 2023 10:09:31 +0100
Message-ID: <4034e634-59d3-e9a5-a1c5-1f275d8e2832@gmx.com>
Date:   Wed, 22 Mar 2023 17:09:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Ext4 <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: A new special orphan inode 12 in ext4 only?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Lj2TGhuEY4N9ivI7PKhSnIW3RmrZeSw4RKNhtGxF/xCTWFDCWZ/
 AtNmVzLQVq05vSanJXdoNsDGvMPA0xN9x1KaGO2/Zau2H2xS5JJU9qC9/cv610LOw6d98hw
 i2eQF9cNTsE1q7r7rapVakwgSnZvcbVt8jNioNKa4mGq5lfNNxMiL/EpX8cUoGWxTcU+wzA
 EB0Q3EOWpknFjjEHbrStw==
UI-OutboundReport: notjunk:1;M01:P0:AQcTDENzByY=;3iesccGb1D2r4WJTvkTB8LdP3hd
 CVAq8IXPgMoOoJsoYLV6PsyqnX+qAbM/IosB+S+yHXpcmo84FOMyBTzd7LvcnnLwCLrDWBXTB
 4ZBqXW0EO3lBu4potDHQaeP10vMSRHDNHpemKQAvbWh9m0hwV7vWwIQAJWNLJ6EF0FFdV3Dhk
 KdbWYI+6UeKvJxo+ABPsfr6o0R9COg/FxuQUwvjPq5+drYZfY2EpnOy+qD/chKdYu6C1Ts8oP
 BNw8o8SZHdF6moB03W9A7U9ItPScdRh28G7Gey+mYF7EUCtXfwwJAK8tv+/5DctmVCMSTFNEx
 0W5JyjM+S/ihlOUVWOOxtAmn2DGTp2VHdAKxPLNk0FYr++u6Ku8o0t9dFX85p/z9uxoCB7Xu6
 k//87vbbB4aRN0KvKWYIdTcynFUCIe2ZbHH24q1RpbEAa33mpcSvn99sHq5sUS0373Sfhi7Yn
 B6WQ1Hj7IWjTreerc5/PkOiTaX5OKhRXsgJiYhwuokGyZjRK6IiB/W5TKqpNn+mZROLshfpmD
 h+NBP90msnK2Xqtsz3/xKzKfbuxl2CnVzBxHl7Koc7OqrRA5kZjZAwc2dHaeYlS1zSVYLk5SR
 4uZQD/rRKxXdwVKhc1zf7dsPjGrjwkYk5XLogYDbPEjp1uHaWO/9kZlCTwdtY0pfWF0tQAWDo
 Vxm3/sV29vGtCBeJZ3bvcYoL2R97vJpsBx8KurUMf2KM9zi6U/TgnufGO2ipJBhUVgPvualgx
 belem22GqOChqLtzhdLjzvyUvmMeFWBneg/FbitItRCH5NHWH0qIVo6efBGyK4rcUmfdLhKh+
 jnSygfBTkr5ZbucXhKSU4LSH+IN+XPbA8lMFkwA8wAfQyjOFb5JkrqJ2yxQPH7qAthLFq9+vK
 fms7iG9Unk7Q+DOI4btpN1T/QHK5iLSOYnbsfBPEr6FlY0Itwxml2qldh8KFEvPNMn7gt+reG
 P0T9TPDaD2cYKEHWaFWc27kJaN4=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Recently I observed newer mkfs.ext4 seems to create a new orphan inode 
12, with some file extents.

Which seems to have no direct parent directory, thus tools like 
btrfs-convert would also follow the ext4 inodes by creating an orphan 
inode too.

On the other hand, if I go mkfs.ext3, the mysterious inode seems to be gone.

Is this inode 12 a known special inode?
If so, how can we avoid such special inode?
(s_special_ino is still 11, thus checking against that value doesn't 
seem to help).


Some details of btrfs-convert:

It goes with ext2fs_open_inode_scan() to iterate all inodes of an ext4.

And if we hit an directory inode, we iterate the directory by using 
ext2fs_dir_iterate2() to insert the dir entries between parent and child 
inodes.

So if we hit an inode without any parent dir, an equivalent btrfs inode 
would still be created, but btrfs-check would complain about such orphan 
inode.

Thanks,
Qu
