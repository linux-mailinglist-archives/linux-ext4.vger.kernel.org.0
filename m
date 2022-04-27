Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4336D51103C
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Apr 2022 06:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357706AbiD0Em5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Apr 2022 00:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbiD0Em4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Apr 2022 00:42:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF2E4237DF
        for <linux-ext4@vger.kernel.org>; Tue, 26 Apr 2022 21:39:46 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 8301520E97A4; Tue, 26 Apr 2022 21:39:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8301520E97A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1651034386;
        bh=mvf7xomBYhl7Co74t9faqT3XYzMDcL4V8dPqZ2i23tM=;
        h=Date:From:To:Subject:From;
        b=SW7aFM0qK9WbuhQTOpEKE04UvwpEj9G0yk5fiFSXlmg/ZZr7jxyK/AnCfZNvtCEQw
         k5fR0wN+ZofB3o5GlKhAahq0eS1XKCFT6oAehppn1GmX837eKgNRQbTt9bpsWV4/YV
         gAbePBl2niMaslHfUjKNPHyaZOoc5V8wE2GhIRbE=
Date:   Tue, 26 Apr 2022 21:39:46 -0700
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     linux-ext4@vger.kernel.org
Subject: [BUG]:OS disk corruption EXT4
Message-ID: <20220427043946.GA21120@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I think I may have run into an issue where my ext4 OS disk shows multiple corruptions and the issue is reproducible after multiple reboots.

Please help me understand this corruption better as I am new to ext4 layouts. 

The “fsck -n <device>” command output was as follows:

fsck from util-linux 2.34                                                                                                                                           
e2fsck 1.45.5 (07-Jan-2020)                                                                                                                                         
ext2fs_open2: Superblock checksum does not match superblock                                                                                                         
fsck.ext4: Superblock invalid, trying backup blocks...                                                                                                             
 Superblock needs_recovery flag is clear, but journal has data.                                                                                                      
Recovery flag not set in backup superblock, so running journal anyway.                                                                                              
Clear journal? no                                                                                                                                                                                                                                                                                                                       
cloudimg-rootfs was not cleanly unmounted, check forced.                                                                                                            
Pass 1: Checking inodes, blocks, and sizes                                                                                                                          
Inode 138, end of extent exceeds allowed value                                                                                                                              
(logical block 14336, physical block 25937920, len 4284)                                                                                                    
Clear? no                                                                                                                                                                                                                                                                                                                               
Inode 138, i_blocks is 146744, should be 114696.  Fix? no                                                                                                                                                                                                                                                                               Deleted inode 38837 has zero dtime.  Fix? no                                                                                                                                                                                                                                                                                            Inode 38855, end of extent exceeds allowed value                                                                                                                            
(logical block 2048, physical block 31733760, len 4)                                                                                                        
Clear? no                                                                                                                                                                                                                                                                                                                               
Inode 38855, end of extent exceeds allowed value                                                                                                                            
(logical block 2054, physical block 31733766, len 51)                                                                                                       
Clear? no                                                                                                                                                                                                                                                                                                                               
Inode 38855, end of extent exceeds allowed value                                                                                                                            
(logical block 2106, physical block 31733818, len 127)                                                                                                     
Clear? no                                                                                                                                                                                                                                                                                                                               
Inode 38855, end of extent exceeds allowed value                                                                                                                            
(logical block 2235, physical block 31733947, len 29)                                                                                                       
Clear? no                                                                                                                                                                                                                                                                                                                               
Inode 38855, end of extent exceeds allowed value                                                                                                                            
(logical block 2267, physical block 31733979, len 93)                                                                                                       
Clear? no                                                                                                                                                                                                                                                                                                                              
Inode 38855, end of extent exceeds allowed value                                                                                                                            
(logical block 2371, physical block 31734083, len 60)                                                                                                       
Clear? no                                                                                                                                                                                                                                                                                                                              
 Inode 38855, end of extent exceeds allowed value                                                                                                                            
(logical block 2442, physical block 31734154, len 16)                                                                                                       
Clear? no                                                                                                                                                                                                                                                                                                                               
Inode 38855, end of extent exceeds allowed value                                                                                                                            
(logical block 2462, physical block 31734174, len 26)                                                                                                       
Clear? no                                                                                                                                                                                                                                                                                                                               
Inode 38855, i_blocks is 16392, should be 29528.  Fix? no                                                                                                                                                                                                                                                                               Inodes that were part of a corrupted orphan linked list found.  Fix? no                                                                                                                                                                                                                                                                 Inode 38870 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 38968 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39069 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39081 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39154 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39172 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39271 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39272 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39278 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39342 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39374 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39378 was part of the orphaned inode list.  IGNORED.                                                                                                         
Inode 39385 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39390 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39396 was part of the orphaned inode list.  IGNORED.                                                                                                         
Inode 39407 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39408 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39416 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39419 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39420 was part of the orphaned inode list.  IGNORED.                                                                                                         
 Inode 39425 was part of the orphaned inode list.  IGNORED.                                                                                                         
 Inode 39426 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39427 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39429 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39430 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39433 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39434 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39435 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39439 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39440 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39442 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39443 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39446 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39448 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39450 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39451 was part of the orphaned inode list.  IGNORED.                                                                                                         
 Inode 39452 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39453 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39456 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39460 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39464 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39468 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39469 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39471 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39472 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39478 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39479 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39480 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39481 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39483 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39484 was part of the orphaned inode list.  IGNORED.                                                                                                         
 Inode 39485 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39486 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39487 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39488 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39489 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39490 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39491 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39493 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39494 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39495 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39498 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39499 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39500 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39502 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39503 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39504 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39506 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39507 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39508 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39509 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39510 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39512 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39513 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39514 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39515 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39517 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39518 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39519 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39520 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39521 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39522 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39523 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39524 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39525 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39526 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39527 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39528 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39529 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39530 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39531 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39532 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39533 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39534 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39535 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39536 was part of the orphaned inode list.  IGNORED.                                                                                                         
 Inode 39537 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39538 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39540 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39541 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39542 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39543 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39544 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39545 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39546 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39547 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39548 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39549 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39552 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39553 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39554 was part of the orphaned inode list.  IGNORED.                                                                                                          
Inode 39557 was part of the orphaned inode list.  IGNORED.                                                                                                         
 Inode 258587, end of extent exceeds allowed value                                                                                                                           
(logical block 512, physical block 25860608, len 28)                                                                                                        
Clear? no                                                                                                                                                                                                                                                                                                                               
Inode 258587, i_blocks is 4280, should be 4104.  Fix? no                                                                                                                                                                                                                                                                                Inode 258658, end of extent exceeds allowed value                                                                                                                           
(logical block 186368, physical block 28665856, len 2116)                                                                                                   
Clear? no                                                                                                                                                                                                                                                                                                                               
Inode 258658, i_blocks is 1506648, should be 1490952.  Fix? no                                                                                                                                                                                                                                                                          Inode 261432, end of extent exceeds allowed value                                                                                                                           
(logical block 1024, physical block 25153536, len 356)                                                                                                      
Clear? no                                                                                                                                                                                                                                                                                                                               
Inode 261432, i_blocks is 11024, should be 8200.  Fix? no                                                                                                                                                                                                                                                                               Inode 266714, end of extent exceeds allowed value                                                                                                                           
(logical block 4096, physical block 28628992, len 2805)                                                                                                     
Clear? no                                                                                                                                                                                                                                                                                                                              
 Inode 266714, i_blocks is 55208, should be 32776.  Fix? no                                                                                                                                                                                                                                                                              Inode 269868 was part of the orphaned inode list.  IGNORED.                                                                                                         
Inode 527158 has an invalid extent node (blk 1100714, lblk 0)                                                                                                       
Clear? no                                                                                                                                                                                                                                                                                                                               
Inode 527158 extent tree (at level 1) could be shorter.  Optimize? no                                                                                                                                                                                                                                                                   Inode 527158, i_blocks is 97320, should be 0.  Fix? no       
.
.
.
Appreciate any help in understanding what might have caused this. 

